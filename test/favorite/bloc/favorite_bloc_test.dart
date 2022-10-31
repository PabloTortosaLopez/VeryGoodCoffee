import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/favorite/favorite.dart';

import '../../mocks/data/mock_coffee_repository.dart';

class MockedCoffee extends Mock implements Coffee {}

void main() {
  group('FavoriteBloc', () {
    late MockCoffeeRepository coffeeRepository;
    late List<Coffee> mockedFavoriteCoffees;
    final newCoffee = MockedCoffee();
    late FavoriteBloc startedSubject;

    setUp(() {
      coffeeRepository = MockCoffeeRepository();
      mockedFavoriteCoffees = [
        MockedCoffee(),
        MockedCoffee(),
        MockedCoffee(),
      ];

      /// Initializing this bloc early allows to update the coffeeRepository
      /// with the [setUp] function
      startedSubject = FavoriteBloc(coffeeRepository: coffeeRepository);
    });

    test('initial state is FavoriteState.initial', () {
      expect(FavoriteBloc(coffeeRepository: coffeeRepository).state,
          equals(FavoriteState.initial()));
    });

    blocTest<FavoriteBloc, FavoriteState>(
      'loads favorite coffees after creation',
      setUp: () =>
          coffeeRepository.mockedFavoriteCoffees = mockedFavoriteCoffees,
      build: () => FavoriteBloc(coffeeRepository: coffeeRepository),
      expect: () => [
        FavoriteState.initial(),
        FavoriteState(
          favoriteCoffees: mockedFavoriteCoffees,
          loadState: FavoriteLoadState.succeded,
        ),
      ],
      verify: (FavoriteBloc cubit) {
        expect(
          cubit.state.favoriteCoffees,
          equals(isNotNull),
        );
      },
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'reloads favorite coffees with a new one',
      setUp: () => coffeeRepository.mockedFavoriteCoffees.add(newCoffee),
      seed: () => FavoriteState(
        favoriteCoffees: mockedFavoriteCoffees,
        loadState: FavoriteLoadState.succeded,
      ),
      act: (FavoriteBloc bloc) => bloc.add(const FavoriteLoadEvent()),
      build: () => startedSubject,
      expect: () => [
        FavoriteState(
          favoriteCoffees: mockedFavoriteCoffees,
          loadState: FavoriteLoadState.loading,
        ),
        FavoriteState(
          favoriteCoffees: coffeeRepository.mockedFavoriteCoffees,
          loadState: FavoriteLoadState.succeded,
        ),
      ],
    );

    group('Error', () {
      blocTest<FavoriteBloc, FavoriteState>(
        'tries to load favorite coffees and fails',
        setUp: () => coffeeRepository.mockedException =
            Exception('Failed to load coffee images'),
        build: () => FavoriteBloc(coffeeRepository: coffeeRepository),
        expect: () => [
          FavoriteState.initial(),
          const FavoriteState(
            favoriteCoffees: [],
            loadState: FavoriteLoadState.failed,
          ),
        ],
        verify: (FavoriteBloc cubit) {
          expect(
            cubit.state.favoriteCoffees,
            equals(isEmpty),
          );
        },
      );
    });
  });
}
