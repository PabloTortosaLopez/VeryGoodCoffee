import 'package:coffee_models/coffee_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/favorite/favorite.dart';

import '../../mocks/data/mock_coffee_repository.dart';

class MockCoffee extends Mock implements Coffee {}

void main() {
  group('FavoriteState', () {
    test('support value equality', () {
      expect(FavoriteState.initial(), equals(FavoriteState.initial()));
    });

    group('copyWith', () {
      test('updates values', () {
        final mockedCoffees = [MockCoffee(), MockedCoffee(), MockCoffee()];
        expect(
            FavoriteState.initial()
                .copyWith(
                  favoriteCoffees: mockedCoffees,
                )
                .favoriteCoffees,
            equals(mockedCoffees));
      });
    });
  });
}
