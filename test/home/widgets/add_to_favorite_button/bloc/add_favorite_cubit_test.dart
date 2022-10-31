import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_api/coffee_api.dart';

import 'package:coffee_models/coffee_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/home/home.dart';

import '../../../../mocks/data/mock_coffee_repository.dart';

class MockedCoffee extends Mock implements Coffee {}

void main() {
  group('AddFavoriteCubit', () {
    late MockCoffeeRepository coffeeRepository;
    late Coffee coffee;

    setUp(() {
      coffeeRepository = MockCoffeeRepository();
      coffee = MockedCoffee();
    });

    test('initial state is AddFavoriteCubit.initial', () {
      expect(AddFavoriteCubit(coffeeRepository: coffeeRepository).state,
          equals(AddFavoriteState.initial()));
    });

    blocTest<AddFavoriteCubit, AddFavoriteState>(
      'adds a coffee to favorites',
      build: () => AddFavoriteCubit(coffeeRepository: coffeeRepository),
      act: (AddFavoriteCubit cubit) => cubit.addCoffeeToFavorites(coffee),
      expect: () => [
        AddFavoriteState.initial()
            .copyWith(addFavoriteStatus: AddFavoriteStatus.adding),
        AddFavoriteState.initial()
            .copyWith(addFavoriteStatus: AddFavoriteStatus.succeded),
      ],
    );

    blocTest<AddFavoriteCubit, AddFavoriteState>(
      'reset addfavorite status',
      build: () => AddFavoriteCubit(coffeeRepository: coffeeRepository),
      seed: () => AddFavoriteState.initial()
          .copyWith(addFavoriteStatus: AddFavoriteStatus.succeded),
      act: (AddFavoriteCubit cubit) => cubit.resetStatus(),
      expect: () => [
        AddFavoriteState.initial()
            .copyWith(addFavoriteStatus: AddFavoriteStatus.idle),
      ],
    );

    group('Error', () {
      blocTest<AddFavoriteCubit, AddFavoriteState>(
        'tries to add a coffee to favorites and fails',
        setUp: () => coffeeRepository.mockedException = Exception(),
        build: () => AddFavoriteCubit(coffeeRepository: coffeeRepository),
        act: (AddFavoriteCubit cubit) => cubit.addCoffeeToFavorites(coffee),
        expect: () => [
          AddFavoriteState.initial()
              .copyWith(addFavoriteStatus: AddFavoriteStatus.adding),
          AddFavoriteState.initial()
              .copyWith(addFavoriteStatus: AddFavoriteStatus.failed),
        ],
      );

      blocTest<AddFavoriteCubit, AddFavoriteState>(
        'tries to add a coffee already added to favorites',
        setUp: () => coffeeRepository.mockedException = AlreadyAddedException(),
        build: () => AddFavoriteCubit(coffeeRepository: coffeeRepository),
        act: (AddFavoriteCubit cubit) => cubit.addCoffeeToFavorites(coffee),
        expect: () => [
          AddFavoriteState.initial()
              .copyWith(addFavoriteStatus: AddFavoriteStatus.adding),
          AddFavoriteState.initial()
              .copyWith(addFavoriteStatus: AddFavoriteStatus.alreadyAdded),
        ],
      );
    });
  });
}
