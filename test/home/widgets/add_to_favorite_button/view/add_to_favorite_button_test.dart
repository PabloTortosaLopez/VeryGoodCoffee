import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/favorite/favorite.dart';
import 'package:very_good_coffee/home/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../helpers/pump_app.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

class FakeHomeState extends Fake implements HomeState {}

class MockAddFavoriteCubit extends MockCubit<AddFavoriteState>
    implements AddFavoriteCubit {}

class FakeAddFavoriteState extends Fake implements AddFavoriteState {}

class MockCoffee extends Mock implements Coffee {}

class MockFavoriteBloc extends MockBloc<FavoriteEvent, FavoriteState>
    implements FavoriteBloc {}

class FakeFavoriteEvent extends Fake implements FavoriteEvent {}

class FakeFavoriteState extends Fake implements FavoriteState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeHomeState());
    registerFallbackValue(FakeAddFavoriteState());
  });

  late HomeCubit homeCubit;
  late AddFavoriteCubit addFavoriteCubit;
  late FavoriteBloc favoriteBloc;
  late Coffee coffee;

  setUp(() {
    homeCubit = MockHomeCubit();
    addFavoriteCubit = MockAddFavoriteCubit();
    favoriteBloc = MockFavoriteBloc();
    coffee = MockCoffee();

    when(() => homeCubit.state).thenReturn(
        HomeState(coffee: coffee, loadState: HomeLoadState.succeded));
    when(() => addFavoriteCubit.state).thenReturn(AddFavoriteState.initial());
  });

  group('AddToFavoritesButton', () {
    testWidgets('renders add to favorites button view', (tester) async {
      await tester.pumpApp(const AddToFavoritesButton(),
          homeCubit: homeCubit,
          addToFavoriteCubit: addFavoriteCubit,
          favoriteBloc: favoriteBloc);

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    group('Icon', () {
      testWidgets('renders when add favorite state is not loading',
          (tester) async {
        await tester.pumpApp(
          const AddToFavoritesButton(),
          homeCubit: homeCubit,
          addToFavoriteCubit: addFavoriteCubit,
        );

        expect(find.byType(Icon), findsOneWidget);
      });

      testWidgets('does not renders when add favorite state is loading',
          (tester) async {
        when(() => addFavoriteCubit.state).thenReturn(const AddFavoriteState(
            addFavoriteStatus: AddFavoriteStatus.adding));
        await tester.pumpApp(
          const AddToFavoritesButton(),
          homeCubit: homeCubit,
          addToFavoriteCubit: addFavoriteCubit,
        );

        expect(find.byType(Icon), findsNothing);
      });
    });

    group('LoadingIndicator', () {
      testWidgets(
          'does not renders CircularProgressIndicator when add favorite state is not loading',
          (tester) async {
        await tester.pumpApp(
          const AddToFavoritesButton(),
          homeCubit: homeCubit,
          addToFavoriteCubit: addFavoriteCubit,
        );

        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
      testWidgets(
          'renders CircularProgressIndicator when add favorite state is loading',
          (tester) async {
        when(() => addFavoriteCubit.state).thenReturn(const AddFavoriteState(
            addFavoriteStatus: AddFavoriteStatus.adding));
        await tester.pumpApp(
          const AddToFavoritesButton(),
          homeCubit: homeCubit,
          addToFavoriteCubit: addFavoriteCubit,
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('FloatingActionButton', () {
      testWidgets('renders floating action button', (tester) async {
        await tester.pumpApp(
          const AddToFavoritesButton(),
          homeCubit: homeCubit,
          addToFavoriteCubit: addFavoriteCubit,
        );

        expect(find.byType(FloatingActionButton), findsOneWidget);
      });

      testWidgets(
          'is enabled when there is a coffee and add favorite state is idle',
          (tester) async {
        await tester.pumpApp(const AddToFavoritesButton(),
            homeCubit: homeCubit,
            addToFavoriteCubit: addFavoriteCubit,
            favoriteBloc: favoriteBloc);

        final floatingActionButton = tester.widget<FloatingActionButton>(
          find.byType(FloatingActionButton),
        );

        expect(floatingActionButton.onPressed, isNotNull);
      });

      testWidgets('calls addCoffeeToFavorites when pressed and is enabled',
          (tester) async {
        await tester.pumpApp(const AddToFavoritesButton(),
            homeCubit: homeCubit,
            addToFavoriteCubit: addFavoriteCubit,
            favoriteBloc: favoriteBloc);

        final floatingActionButton = tester.widget<FloatingActionButton>(
          find.byType(FloatingActionButton),
        );
        floatingActionButton.onPressed!();

        verify(() => addFavoriteCubit.addCoffeeToFavorites(coffee)).called(1);
      });

      testWidgets(
          'is not enabled when there is not a coffee and add favorite state is idle',
          (tester) async {
        when(() => homeCubit.state).thenReturn(HomeState.initial());
        await tester.pumpApp(const AddToFavoritesButton(),
            homeCubit: homeCubit, addToFavoriteCubit: addFavoriteCubit);

        final floatingActionButton = tester.widget<FloatingActionButton>(
          find.byType(FloatingActionButton),
        );

        expect(floatingActionButton.onPressed, isNull);
      });

      testWidgets(
          'is not enabled when there is a coffee and add favorite state is not idle',
          (tester) async {
        when(() => addFavoriteCubit.state).thenReturn(const AddFavoriteState(
            addFavoriteStatus: AddFavoriteStatus.adding));
        await tester.pumpApp(const AddToFavoritesButton(),
            homeCubit: homeCubit, addToFavoriteCubit: addFavoriteCubit);

        final floatingActionButton = tester.widget<FloatingActionButton>(
          find.byType(FloatingActionButton),
        );

        expect(floatingActionButton.onPressed, isNull);
      });

      testWidgets(
          'is not enabled when there is not a coffee and add favorite state is not idle',
          (tester) async {
        when(() => homeCubit.state).thenReturn(HomeState.initial());
        when(() => addFavoriteCubit.state).thenReturn(const AddFavoriteState(
            addFavoriteStatus: AddFavoriteStatus.adding));

        await tester.pumpApp(const AddToFavoritesButton(),
            homeCubit: homeCubit, addToFavoriteCubit: addFavoriteCubit);

        final floatingActionButton = tester.widget<FloatingActionButton>(
          find.byType(FloatingActionButton),
        );

        expect(floatingActionButton.onPressed, isNull);
      });
    });

    group('SnackBar listener', () {
      /// Simulates button on a screen with Scaffold as parent in order to present a snackbar
      const scaffoldWithButton = Scaffold(body: AddToFavoritesButton());
      testWidgets('calls FavoriteLoadEvent when state is succeded',
          (tester) async {
        whenListen(
          addFavoriteCubit,
          Stream<AddFavoriteState>.fromIterable([
            AddFavoriteState.initial(),
            const AddFavoriteState(
                addFavoriteStatus: AddFavoriteStatus.succeded),
          ]),
        );

        await tester.pumpApp(scaffoldWithButton,
            homeCubit: homeCubit,
            addToFavoriteCubit: addFavoriteCubit,
            favoriteBloc: favoriteBloc);

        verify((() => favoriteBloc.add(const FavoriteLoadEvent()))).called(1);
      });

      testWidgets('does not calls FavoriteLoadEvent if state is not succeded',
          (tester) async {
        whenListen(
          addFavoriteCubit,
          Stream<AddFavoriteState>.fromIterable([
            AddFavoriteState.initial(),
            const AddFavoriteState(
                addFavoriteStatus: AddFavoriteStatus.alreadyAdded),
          ]),
        );

        await tester.pumpApp(scaffoldWithButton,
            homeCubit: homeCubit,
            addToFavoriteCubit: addFavoriteCubit,
            favoriteBloc: favoriteBloc);

        verifyNever((() => favoriteBloc.add(const FavoriteLoadEvent())));
      });

      testWidgets('snack title and color corresponds to already added state',
          (tester) async {
        whenListen(
          addFavoriteCubit,
          Stream<AddFavoriteState>.fromIterable([
            AddFavoriteState.initial(),
            const AddFavoriteState(
                addFavoriteStatus: AddFavoriteStatus.alreadyAdded),
          ]),
        );

        await tester.pumpApp(scaffoldWithButton,
            homeCubit: homeCubit,
            addToFavoriteCubit: addFavoriteCubit,
            favoriteBloc: favoriteBloc);

        await tester.pumpAndSettle(const Duration(seconds: 4));

        /// Maybe there is a better way to test localizations here?
        final snackAlreadyAddedTitle =
            (await AppLocalizations.delegate.load(const Locale('en')))
                .coffeeAlreadyAdded;

        final snackBar = tester.widget<SnackBar>(
          find.byType(SnackBar),
        );

        expect(snackBar.backgroundColor!.value, equals(Colors.amber.value));

        expect((snackBar.content as Text).data, equals(snackAlreadyAddedTitle));
      });

      testWidgets('snack title and color corresponds to succeded state',
          (tester) async {
        whenListen(
          addFavoriteCubit,
          Stream<AddFavoriteState>.fromIterable([
            AddFavoriteState.initial(),
            const AddFavoriteState(
                addFavoriteStatus: AddFavoriteStatus.succeded),
          ]),
        );

        await tester.pumpApp(scaffoldWithButton,
            homeCubit: homeCubit,
            addToFavoriteCubit: addFavoriteCubit,
            favoriteBloc: favoriteBloc);

        await tester.pumpAndSettle(const Duration(seconds: 4));

        final snackAddedTitle =
            (await AppLocalizations.delegate.load(const Locale('en')))
                .coffeeAddedToFavorites;

        final snackBar = tester.widget<SnackBar>(
          find.byType(SnackBar),
        );

        expect(snackBar.backgroundColor!.value, equals(Colors.green.value));

        expect((snackBar.content as Text).data, equals(snackAddedTitle));
      });

      testWidgets('snack title and color corresponds to failed state',
          (tester) async {
        whenListen(
          addFavoriteCubit,
          Stream<AddFavoriteState>.fromIterable([
            AddFavoriteState.initial(),
            const AddFavoriteState(addFavoriteStatus: AddFavoriteStatus.failed),
          ]),
        );

        await tester.pumpApp(scaffoldWithButton,
            homeCubit: homeCubit,
            addToFavoriteCubit: addFavoriteCubit,
            favoriteBloc: favoriteBloc);

        await tester.pumpAndSettle(const Duration(seconds: 4));

        final snackErrorTitle =
            (await AppLocalizations.delegate.load(const Locale('en')))
                .somethinWrongHappened;

        final snackBar = tester.widget<SnackBar>(
          find.byType(SnackBar),
        );

        expect(snackBar.backgroundColor!.value, equals(Colors.red.value));

        expect((snackBar.content as Text).data, equals(snackErrorTitle));
      });

      testWidgets('snack is not called when state is adding', (tester) async {
        whenListen(
          addFavoriteCubit,
          Stream<AddFavoriteState>.fromIterable([
            AddFavoriteState.initial(),
            const AddFavoriteState(addFavoriteStatus: AddFavoriteStatus.adding),
          ]),
        );

        await tester.pumpApp(scaffoldWithButton,
            homeCubit: homeCubit,
            addToFavoriteCubit: addFavoriteCubit,
            favoriteBloc: favoriteBloc);

        expect(find.byType(SnackBar), findsNothing);
      });

      testWidgets('snack is not called when state is idle', (tester) async {
        whenListen(
          addFavoriteCubit,
          Stream<AddFavoriteState>.fromIterable([
            const AddFavoriteState(
                addFavoriteStatus: AddFavoriteStatus.succeded),
            const AddFavoriteState(addFavoriteStatus: AddFavoriteStatus.idle),
          ]),
        );

        await tester.pumpApp(scaffoldWithButton,
            homeCubit: homeCubit,
            addToFavoriteCubit: addFavoriteCubit,
            favoriteBloc: favoriteBloc);

        expect(find.byType(SnackBar), findsNothing);
      });

      /// I can't find at the moment a way to test the {onFinished} callback
      /// that is executed when the snackbar finishes displaying
      ///
      // testWidgets(
      //     'calls resetStatus from AddFavoriteCubit when state is succeded',
      //     (tester) async {
      //   whenListen(
      //     addFavoriteCubit,
      //     Stream<AddFavoriteState>.fromIterable([
      //       AddFavoriteState.initial(),
      //       const AddFavoriteState(
      //           addFavoriteStatus: AddFavoriteStatus.succeded),
      //     ]),
      //   );

      //   await tester.pumpApp(scaffoldWithButton,
      //       homeCubit: homeCubit,
      //       addToFavoriteCubit: addFavoriteCubit,
      //       favoriteBloc: favoriteBloc);

      //   await tester.pumpAndSettle(const Duration(seconds: 4));

      //   final snackBar = tester.widget<SnackBar>(
      //     find.byType(SnackBar),
      //   );
      //   expect(snackBar, isNotNull);
      //   verify((() => addFavoriteCubit.resetStatus())).called(1);
      // });
    });
  });
}
