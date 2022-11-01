import 'dart:typed_data';

import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpWrapper extends Mock implements HttpWrapper {}

void main() {
  group('CoffeeClient', () {
    const coffeeUrl = 'https://coffee.alexflipnote.dev/4FU4XKzOd40_coffee.png';
    const responseBody = '{ "file": "$coffeeUrl"}';
    final randomCoffeeUrl =
        const CoffeeURLFactory().getUrl(endpoint: CoffeeEndpoint.random);
    late HttpWrapper httpWrapper;
    late CoffeeClient coffeeClient;

    setUp(() {
      httpWrapper = MockHttpWrapper();
      coffeeClient = CoffeeClient(http: httpWrapper);
    });

    group('loadRandomCoffee', () {
      setUp(() {
        when(
          () => httpWrapper.get(randomCoffeeUrl),
        ).thenAnswer((_) => Future.value(Response(responseBody, 200)));
      });

      test('calls get from HttpWrapper to retrieve a random coffee', () async {
        await coffeeClient.loadRandomCoffee();
        verify(
          () => httpWrapper.get(randomCoffeeUrl),
        ).called(1);
      });

      test('succeeds when loadRandomCoffee succeeds', () async {
        expect(
          coffeeClient.loadRandomCoffee(),
          completes,
        );
      });

      test('returns a coffee if reponse status code is 200', () async {
        final coffee = await coffeeClient.loadRandomCoffee();

        expect(
          coffee,
          isA<Coffee>(),
        );
      });

      test('throws a HttpException if reponse status code is not 200',
          () async {
        when(
          () => httpWrapper.get(randomCoffeeUrl),
        ).thenAnswer((_) => Future.value(Response('error', 400)));

        expect(
          () => coffeeClient.loadRandomCoffee(),
          throwsA(isA<HttpException>()),
        );
      });
    });

    group('getImageDataFromCoffee', () {
      setUp(() {
        when(
          () => httpWrapper.get(coffeeUrl),
        ).thenAnswer((_) => Future.value(Response(responseBody, 200)));
      });
      test('calls get from HttpWrapper to retrieve a coffee image data',
          () async {
        await coffeeClient.getImageDataFromCoffee(coffeeUrl);
        verify(
          () => httpWrapper.get(coffeeUrl),
        ).called(1);
      });

      test('succeeds when getImageDataFromCoffee succeeds', () async {
        expect(
          coffeeClient.getImageDataFromCoffee(coffeeUrl),
          completes,
        );
      });

      test('returns a Uint8List if reponse status code is 200', () async {
        final coffeeData = await coffeeClient.getImageDataFromCoffee(coffeeUrl);

        expect(
          coffeeData,
          isA<Uint8List>(),
        );
      });

      test('throws a HttpException if reponse status code is not 200',
          () async {
        when(
          () => httpWrapper.get(coffeeUrl),
        ).thenAnswer((_) => Future.value(Response('error', 400)));

        expect(
          () => coffeeClient.getImageDataFromCoffee(coffeeUrl),
          throwsA(isA<HttpException>()),
        );
      });
    });
  });
}
