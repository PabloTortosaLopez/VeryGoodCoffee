import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_models/coffee_models.dart' as models;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/home/home.dart';

import '../../helpers/pump_app.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

class FakeHomeState extends Fake implements HomeState {}

class MockAddFavoriteCubit extends MockCubit<AddFavoriteState>
    implements AddFavoriteCubit {}

class FakeAddFavoriteState extends Fake implements AddFavoriteState {}

class MockCoffee extends Mock implements models.Coffee {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeHomeState());
    registerFallbackValue(FakeAddFavoriteState());
  });

  late HomeCubit homeCubit;
  late AddFavoriteCubit addFavoriteCubit;
  late models.Coffee coffee;

  setUp(() {
    homeCubit = MockHomeCubit();
    addFavoriteCubit = MockAddFavoriteCubit();
    coffee = MockCoffee();

    when(() => homeCubit.state).thenReturn(HomeState.initial());
    when(() => addFavoriteCubit.state).thenReturn(AddFavoriteState.initial());
  });
  group('HomeScreen', () {
    testWidgets('renders home screen', (tester) async {
      await tester.pumpApp(const HomeScreen(),
          homeCubit: homeCubit, addToFavoriteCubit: addFavoriteCubit);

      expect(find.byType(CoffeeImageView), findsOneWidget);
      expect(find.byType(AddToFavoritesButton), findsOneWidget);
    });

    group('AppBar', () {
      testWidgets('renders 2 action buttons', (tester) async {
        await tester.pumpApp(const HomeScreen(),
            homeCubit: homeCubit, addToFavoriteCubit: addFavoriteCubit);

        expect(find.byType(CoffeeActionButton), findsNWidgets(2));
      });

      testWidgets('renders go to favorites action button', (tester) async {
        await tester.pumpApp(const HomeScreen(),
            homeCubit: homeCubit, addToFavoriteCubit: addFavoriteCubit);

        expect(
            find.byKey(const Key('home_go_to_favorites_coffee_action_button')),
            findsNWidgets(1));
      });

      /// pumpApp needs a custom GoRouter in order to test navigation.
      /// Right now there is only one navigation, so it is not worth the effort.
      ///
      // testWidgets('go to favorites button navigates to favorites screen',
      //     (tester) async {
      //   await tester.pumpApp(const HomeScreen(),
      //       homeCubit: homeCubit, addToFavoriteCubit: addFavoriteCubit);
      //   //await tester.pumpAndSettle();

      //   final goToFavoritesButton = tester.widget<CoffeeActionButton>(
      //     find.byKey(const Key('goToFavorites')),
      //   );

      //   goToFavoritesButton.onPressed();

      //   await tester.pumpAndSettle();

      //   expect(find.byType(FavoriteCoffeesScreen), findsOneWidget);
      // });

      testWidgets('renders reload coffee action button', (tester) async {
        await tester.pumpApp(const HomeScreen(),
            homeCubit: homeCubit, addToFavoriteCubit: addFavoriteCubit);

        expect(find.byKey(const Key('home_reload_coffee_coffee_action_button')),
            findsNWidgets(1));
      });

      testWidgets(
          'reload coffee button calls reloadRandomCoffee from home cubit',
          (tester) async {
        await tester.pumpApp(const HomeScreen(),
            homeCubit: homeCubit, addToFavoriteCubit: addFavoriteCubit);

        final goToFavoritesButton = tester.widget<CoffeeActionButton>(
          find.byKey(const Key('home_reload_coffee_coffee_action_button')),
        );

        goToFavoritesButton.onPressed();

        verify(() => homeCubit.reloadRandomCoffee()).called(1);
      });
    });
  });

  group('CoffeeImageView', () {
    testWidgets('renders circular progress indicator when initializing',
        (tester) async {
      await tester.pumpApp(const CoffeeImageView(), homeCubit: homeCubit);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders text error when something went wrong', (tester) async {
      when(() => homeCubit.state).thenReturn(
          const HomeState(coffee: null, loadState: HomeLoadState.failed));
      await tester.pumpApp(const CoffeeImageView(), homeCubit: homeCubit);

      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('renders url image when coffee is loaded', (tester) async {
      when(() => coffee.image).thenReturn(models.Image.url(
          url: 'https://coffee.alexflipnote.dev/d_YLKkIzaZA_coffee.jpg'));
      when(() => homeCubit.state).thenReturn(
          HomeState(coffee: coffee, loadState: HomeLoadState.succeded));

      await tester.pumpApp(const CoffeeImageView(), homeCubit: homeCubit);

      expect(find.byType(FadeInImage), findsOneWidget);
    });
  });
}
