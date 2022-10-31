import 'package:flutter/material.dart';

import 'app/app.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(App(settingsController: settingsController));
}
