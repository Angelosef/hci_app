import 'package:flutter/material.dart';
import 'package:frontend/models/settings.dart';
import 'package:frontend/services/settings_service.dart';
import 'package:logger/logger.dart';

class SettingsProvider extends ChangeNotifier {
  final Logger logger = Logger(level: Level.debug);
  Settings _settings = Settings(
    userId: 0,
    notificationsEnabled: true, 
  );

  Settings get() {
    return _settings;
  }

  void set(Settings settings) {
    _settings = settings;
    logger.d(_settings.toJson());
    notifyListeners();
  }

  void clear() {
    set(Settings(userId: 0, notificationsEnabled: true));
  }

  Future<void> initialize(int userId) async {
    SettingsService settingsService = SettingsService();
    Settings settings = await settingsService.getSettings(userId);
    set(settings);
  }
}
