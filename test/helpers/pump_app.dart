import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_repositories/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/favorite/favorite.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:very_good_coffee/home/home.dart';

import '../mocks/data/mock_coffee_repository.dart';

class FakeHomeState extends Fake implements HomeState {}

class FakeAddFavoriteState extends Fake implements AddFavoriteState {}

class FakeFavoriteState extends Fake implements FavoriteState {}

class FakeFavoriteEvent extends Fake implements FavoriteEvent {}

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

class MockAddToFavoriteCubit extends MockCubit<AddFavoriteState>
    implements AddFavoriteCubit {}

class MockFavoriteBloc extends MockBloc<FavoriteEvent, FavoriteState>
    implements FavoriteBloc {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    CoffeeRepository? coffeeRepository,
    HomeCubit? homeCubit,
    AddFavoriteCubit? addToFavoriteCubit,
    FavoriteBloc? favoriteBloc,
  }) async {
    registerFallbackValue(FakeHomeState());

    registerFallbackValue(FakeAddFavoriteState());

    registerFallbackValue(FakeFavoriteState());
    registerFallbackValue(FakeFavoriteEvent());

    return pumpWidget(
      RepositoryProvider.value(
        value: coffeeRepository ?? MockCoffeeRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: homeCubit ?? MockHomeCubit()),
            BlocProvider.value(
                value: addToFavoriteCubit ?? MockAddToFavoriteCubit()),
            BlocProvider.value(value: favoriteBloc ?? MockFavoriteBloc()),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale.fromSubtags(languageCode: 'en'),
              Locale.fromSubtags(languageCode: 'es'),
            ],
            home: widget,
          ),
        ),
      ),
    );
  }
}
