import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/app/app.dart';
import 'package:very_good_coffee/home/home.dart';

class MockSettingsController extends Mock implements SettingsController {
  @override
  ThemeMode get themeMode => ThemeMode.dark;
}

void main() {
  group('App', () {
    testWidgets('uses dark mode from user settings', (tester) async {
      await tester
          .pumpWidget(App(settingsController: MockSettingsController()));

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      expect(materialApp.themeMode, equals(ThemeMode.dark));
    });

    testWidgets('renders HomeScreen', (tester) async {
      await tester
          .pumpWidget(App(settingsController: MockSettingsController()));
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
