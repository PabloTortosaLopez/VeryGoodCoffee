import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee/favorite/favorite.dart';

import '../../mocks/data/mock_coffee_repository.dart';

void main() {
  group('FavoriteBloc', () {
    late MockCoffeeRepository coffeeRepository;

    setUp(() {
      coffeeRepository = MockCoffeeRepository();
      // coffee = MockedCoffee();
      // anotherCoffee = MockedCoffee();
    });

    test('initial state is FavoriteState.initial', () {
      expect(FavoriteBloc(coffeeRepository: coffeeRepository).state,
          equals(FavoriteState.initial()));
    });
  });
}
