import 'dart:typed_data';

import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_models/coffee_models.dart' as models;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPrefs extends Mock implements CoffeeSharedPrefs {}

class MockCoffee extends Mock implements models.Coffee {}

void main() {
  group('LocalCoffeeClient', () {
    late CoffeeSharedPrefs sharedPrefs;

    final mockedImageData = Uint8List.fromList([1, 2, 3, 4]);
    late List<String> storedCoffeePaths;
    late LocalCoffeeClient localCoffeeClient;
    late models.Coffee coffee;

    setUp(() {
      sharedPrefs = MockSharedPrefs();
      storedCoffeePaths = [
        '4FU4XKzOd40_coffee.png',
        '5FU4XKzOd40_coffee.jpg',
        '6FU4XKzOd40_coffee.png',
      ];
      coffee = MockCoffee();

      localCoffeeClient = LocalCoffeeClient(
        sharedPrefs: sharedPrefs,
        useStubFileManager: true,
      );
    });

    group('loadFavoriteCoffees', () {
      setUp(() {
        when(
          () => sharedPrefs.recoverFavoriteCoffeeImages(),
        ).thenAnswer((_) => Future.value(storedCoffeePaths));
      });

      test(
          'calls recoverFavoriteCoffeeImages from coffee shared preferences to retrieve stored favorite coffees',
          () async {
        await localCoffeeClient.loadFavoriteCoffees();
        verify(
          () => sharedPrefs.recoverFavoriteCoffeeImages(),
        ).called(1);
      });

      test('succeeds when loadFavoriteCoffees succeeds', () async {
        expect(
          localCoffeeClient.loadFavoriteCoffees(),
          completes,
        );
      });

      test('returns stored favorite coffees', () async {
        final favoriteCoffees = await localCoffeeClient.loadFavoriteCoffees();

        expect(
          favoriteCoffees,
          isA<List<models.Coffee>>(),
        );
      });
    });

    group('addCoffeeToFavorites', () {
      setUp(() {
        when(() => coffee.image).thenReturn(models.Image.url(
            url: 'https://coffee.alexflipnote.dev/asdjfka34.jpg'));
        when(() => sharedPrefs.storeFavoriteCoffeeImage(testPath))
            .thenAnswer((_) async => Future.value(null));
      });

      test(
          'calls storeFavoriteCoffeeImage from coffee shared preferences to store coffee image path',
          () async {
        await localCoffeeClient.addCoffeeToFavorites(coffee, mockedImageData);
        verify(
          () => sharedPrefs.storeFavoriteCoffeeImage(testPath),
        ).called(1);
      });

      test('succeeds when addCoffeeToFavorites succeeds', () async {
        expect(
          localCoffeeClient.addCoffeeToFavorites(coffee, mockedImageData),
          completes,
        );
      });

      test('throws an exception if there was an error writing file', () async {
        localCoffeeClient = LocalCoffeeClient(
          sharedPrefs: sharedPrefs,
          useStubFileManager: true,
          imageFileAlwaysNull: true,
        );

        expect(
          () => localCoffeeClient.addCoffeeToFavorites(coffee, mockedImageData),
          throwsA(isA<Exception>()),
        );
        verifyNever(
          () => sharedPrefs.storeFavoriteCoffeeImage(testPath),
        );
      });
    });
  });
}
