import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/settings/settings_controller.dart';
import 'app/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));
}
