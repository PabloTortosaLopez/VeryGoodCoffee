import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/home/home.dart';

import '../../mocks/data/mock_coffee_repository.dart';

class MockedCoffee extends Mock implements Coffee {}

void main() {
  group('HomeCubit', () {
    late MockCoffeeRepository coffeeRepository;
    late Coffee coffee;
    late Coffee anotherCoffee;

    setUp(() {
      coffeeRepository = MockCoffeeRepository();
      coffee = MockedCoffee();
      anotherCoffee = MockedCoffee();
    });

    test('initial state is HomeState.initial', () {
      expect(HomeCubit(coffeeRepository: coffeeRepository).state,
          equals(HomeState.initial()));
    });

    blocTest<HomeCubit, HomeState>(
      'loads a new coffee just after creation',
      setUp: () => coffeeRepository.mockedCoffee = coffee,
      build: () => HomeCubit(coffeeRepository: coffeeRepository),
      expect: () => [
        HomeState.initial().copyWith(
          coffee: () => coffee,
          loadState: HomeLoadState.succeded,
        ),
      ],
      verify: (HomeCubit cubit) {
        expect(
          cubit.state.coffee,
          equals(isNotNull),
        );
      },
    );

    blocTest<HomeCubit, HomeState>(
      'reloads a random coffee',
      setUp: () => coffeeRepository.mockedCoffee = anotherCoffee,
      build: () => HomeCubit(coffeeRepository: coffeeRepository),
      seed: () => HomeState(coffee: coffee, loadState: HomeLoadState.succeded),
      act: (HomeCubit cubit) => cubit.reloadRandomCoffee(),
      expect: () => [
        HomeState.initial(),
        HomeState.initial().copyWith(
          coffee: () => anotherCoffee,
          loadState: HomeLoadState.succeded,
        ),
      ],
      verify: (HomeCubit cubit) {
        expect(
          cubit.state.coffee,
          equals(isNotNull),
        );
      },
    );

    blocTest<HomeCubit, HomeState>(
      'tries to reload a randomCoffee but state is already loading',
      build: () => HomeCubit(coffeeRepository: coffeeRepository),
      skip: 1, // Skips initial state
      seed: () =>
          const HomeState(coffee: null, loadState: HomeLoadState.loading),
      act: (HomeCubit cubit) => cubit.reloadRandomCoffee(),
      expect: () => [],
    );

    group('Error', () {
      blocTest<HomeCubit, HomeState>(
        'tries to load a new coffee just after creation and fails',
        setUp: () => coffeeRepository.mockedException =
            const HttpException(code: 123, body: 'No Internet'),
        build: () => HomeCubit(coffeeRepository: coffeeRepository),
        expect: () => [
          HomeState.initial().copyWith(
            loadState: HomeLoadState.failed,
          ),
        ],
        verify: (HomeCubit cubit) {
          expect(
            cubit.state.coffee,
            equals(isNull),
          );
        },
      );
    });
  });
}
