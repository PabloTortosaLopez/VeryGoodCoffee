import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_models/coffee_models.dart' as models;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/favorite/favorite.dart';

import '../../helpers/pump_app.dart';

class MockFavoriteBloc extends MockBloc<FavoriteEvent, FavoriteState>
    implements FavoriteBloc {}

class FakeFavoriteEvent extends Fake implements FavoriteEvent {}

class FakeFavoriteState extends Fake implements FavoriteState {}

class MockCoffee extends Mock implements models.Coffee {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeFavoriteEvent());
    registerFallbackValue(FakeFavoriteState());
  });

  late FavoriteBloc favoriteBloc;
  late models.Coffee coffee;
  late List<models.Coffee> favoriteCoffees;

  setUp(() {
    favoriteBloc = MockFavoriteBloc();
    coffee = MockCoffee();
    favoriteCoffees = [coffee, coffee, coffee];

    when((() => favoriteBloc.state)).thenReturn(FavoriteState.initial());
  });

  group('FavoriteCoffeesScreen', () {
    testWidgets('renders FavoriteCoffeesView', (tester) async {
      await tester.pumpApp(const FavoriteCoffeesScreen(),
          favoriteBloc: favoriteBloc);

      expect(find.byType(FavoriteCoffeesView), findsOneWidget);
    });

    group('FavoriteCoffeesView', () {
      testWidgets('renders CircularProgressIndicator when state is loading',
          (tester) async {
        await tester.pumpApp(const FavoriteCoffeesView(),
            favoriteBloc: favoriteBloc);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('renders CoffeeList when state is succeded', (tester) async {
        when(() => coffee.image)
            .thenReturn(models.Image.path(path: 'documents/coffee.png'));
        when((() => favoriteBloc.state)).thenReturn(FavoriteState(
            favoriteCoffees: favoriteCoffees,
            loadState: FavoriteLoadState.succeded));
        await tester.pumpApp(const FavoriteCoffeesView(),
            favoriteBloc: favoriteBloc);

        expect(find.byType(CoffeeList), findsOneWidget);
      });

      testWidgets('renders TryAgainCTA when state is failed', (tester) async {
        when((() => favoriteBloc.state)).thenReturn(FavoriteState.initial()
            .copyWith(loadState: FavoriteLoadState.failed));
        await tester.pumpApp(const Scaffold(body: FavoriteCoffeesView()),
            favoriteBloc: favoriteBloc);
        expect(find.byType(TryAgainCTA), findsOneWidget);
      });
    });

    group('CoffeeList', () {
      testWidgets(
          'renders coffees list when state is succeded and there are favorite coffees',
          (tester) async {
        when(() => coffee.image)
            .thenReturn(models.Image.path(path: 'documents/coffee.png'));
        when((() => favoriteBloc.state)).thenReturn(FavoriteState(
            favoriteCoffees: favoriteCoffees,
            loadState: FavoriteLoadState.succeded));
        await tester.pumpApp(const FavoriteCoffeesView(),
            favoriteBloc: favoriteBloc);

        expect(find.byType(ListView), findsOneWidget);
      });

      testWidgets('renders empty coffees widget', (tester) async {
        when((() => favoriteBloc.state)).thenReturn(const FavoriteState(
            favoriteCoffees: [], loadState: FavoriteLoadState.succeded));
        await tester.pumpApp(const FavoriteCoffeesView(),
            favoriteBloc: favoriteBloc);

        expect(find.byType(Text), findsOneWidget);
      });
    });
  });
}
