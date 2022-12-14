import 'package:coffee_models/coffee_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/home/home.dart';

class MockCoffee extends Mock implements Coffee {}

void main() {
  group('HomeState', () {
    test('support value equality', () {
      expect(HomeState.initial(), equals(HomeState.initial()));
    });

    group('copyWith', () {
      test('updates values', () {
        final mockedCoffee = MockCoffee();
        expect(
            HomeState.initial()
                .copyWith(
                  coffee: () => mockedCoffee,
                )
                .coffee,
            equals(mockedCoffee));
      });

      test('allows setting coffee to null', () {
        final mockedCoffee = MockCoffee();
        expect(
            HomeState(coffee: mockedCoffee, loadState: HomeLoadState.succeded)
                .copyWith(
                  coffee: () => null,
                )
                .coffee,
            equals(null));
      });
    });
  });
}
