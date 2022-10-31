import 'dart:typed_data';

import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:coffee_repositories/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeClient extends Mock implements CoffeeClient {}

class MockLocalCoffeeClient extends Mock implements LocalCoffeeClient {}

class MockRandomCoffee extends Mock implements Coffee {
  @override
  final Image image;
  MockRandomCoffee(this.image);
}

void main() {
  group('CoffeeRepository', () {
    late CoffeeRepository coffeeRepository;
    late CoffeeClient coffeeClient;
    late LocalCoffeeClient localCoffeeClient;
    final mockedImageData = Uint8List.fromList([1, 2, 3, 4]);
    late MockRandomCoffee mockRandomCoffee;

    setUp(() {
      coffeeClient = MockCoffeeClient();
      localCoffeeClient = MockLocalCoffeeClient();
      coffeeRepository = CoffeeRepository(
        coffeeClient: coffeeClient,
        localCoffeeClient: localCoffeeClient,
      );
      mockRandomCoffee = MockRandomCoffee(Image.url(
          url: 'https://coffee.alexflipnote.dev/d_YLKkIzaZA_coffee.jpg'));
    });

    group('loadRandomCoffee', () {
      setUp(() {
        when(
          () => coffeeClient.loadRandomCoffee(),
        ).thenAnswer((_) => Future.value(mockRandomCoffee));
      });

      test('calls loadRandomCoffee from coffee client', () async {
        await coffeeRepository.loadRandomCoffee();
        verify(
          () => coffeeClient.loadRandomCoffee(),
        ).called(1);
      });

      test('succeeds when loadRandomCoffee succeeds', () async {
        expect(
          coffeeRepository.loadRandomCoffee(),
          completes,
        );
      });

      test('loadRandomCoffee returns a coffee', () async {
        final coffee = await coffeeRepository.loadRandomCoffee();

        expect(
          coffee,
          isA<Coffee>(),
        );
      });
    });

    group('loadFavoriteCoffees', () {
      setUp(() {
        when(
          () => localCoffeeClient.loadFavoriteCoffees(),
        ).thenAnswer((_) => Future.value([mockRandomCoffee]));
      });

      test('calls loadFavoriteCoffees from local coffee client', () async {
        await coffeeRepository.loadFavoriteCoffees();
        verify(
          () => localCoffeeClient.loadFavoriteCoffees(),
        ).called(1);
      });

      test('succeeds when loadFavoriteCoffees succeeds', () async {
        expect(
          coffeeRepository.loadFavoriteCoffees(),
          completes,
        );
      });

      test('loadFavoriteCoffees returns a coffee list', () async {
        final coffee = await coffeeRepository.loadFavoriteCoffees();

        expect(
          coffee,
          isA<List<Coffee>>(),
        );
      });
    });

    group('addCoffeeToFavorites', () {
      setUp(() {
        when(
          () => coffeeClient.getImageDataFromCoffee(mockRandomCoffee.image.raw),
        ).thenAnswer((_) => Future.value(mockedImageData));

        when(() => localCoffeeClient.addCoffeeToFavorites(
            mockRandomCoffee, mockedImageData)).thenAnswer((_) async => {});
      });

      test(
          'calls getImageDataFromCoffee from coffee client and addCoffeeToFavorites from local coffee client',
          () async {
        await coffeeRepository.addCoffeeToFavorites(mockRandomCoffee);
        verify(
          () => coffeeClient.getImageDataFromCoffee(mockRandomCoffee.image.raw),
        ).called(1);
        verify(
          () => localCoffeeClient.addCoffeeToFavorites(
              mockRandomCoffee, mockedImageData),
        ).called(1);
      });

      test('succeeds when addCoffeeToFavorites succeeds', () async {
        expect(
          coffeeRepository.addCoffeeToFavorites(mockRandomCoffee),
          completes,
        );
      });
    });
  });
}
