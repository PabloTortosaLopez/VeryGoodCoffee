import 'package:flutter/material.dart';

/// A service that retrieves user settings.

class SettingsService {
  Future<ThemeMode> themeMode() async => ThemeMode.system;
}
