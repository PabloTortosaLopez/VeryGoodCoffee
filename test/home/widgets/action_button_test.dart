import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/home/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/pump_app.dart';

class MockCallbackFunction extends Mock {
  void call();
}

void main() {
  group('ActionButton', () {
    testWidgets('renders widget with a goToFavorites configuration',
        (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: CoffeeActionButton(
            buttonType: CoffeeButtonType.goTofavorites,
            onPressed: () {},
          ),
        ),
      );
      final title = tester.widget<Text>(find.byType(Text));
      final buttonIcon = tester.widget<IconButton>(find.byType(IconButton));

      final favoritesTitle =
          (await AppLocalizations.delegate.load(const Locale('en'))).favorites;
      expect(title.data, equals(favoritesTitle));

      expect(buttonIcon.icon.toString(),
          equals(const Icon(Icons.favorite).toString()));
    });

    testWidgets('renders widget with a reloadCoffee configuration',
        (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: CoffeeActionButton(
            buttonType: CoffeeButtonType.reloadCoffee,
            onPressed: () {},
          ),
        ),
      );
      final title = tester.widget<Text>(find.byType(Text));
      final buttonIcon = tester.widget<IconButton>(find.byType(IconButton));

      final coffeeTitle =
          (await AppLocalizations.delegate.load(const Locale('en'))).coffee;
      expect(title.data, equals(coffeeTitle));

      expect(buttonIcon.icon.toString(),
          equals(const Icon(Icons.coffee).toString()));
    });

    testWidgets('executes callback when called', (tester) async {
      final mockedCallbackFunction = MockCallbackFunction();

      await tester.pumpApp(
        Scaffold(
          body: CoffeeActionButton(
            buttonType: CoffeeButtonType.reloadCoffee,
            onPressed: () {
              mockedCallbackFunction.call();
            },
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      verify(() => mockedCallbackFunction.call()).called(1);
    });
  });
}
