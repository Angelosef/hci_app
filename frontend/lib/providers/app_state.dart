import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/settings.dart';


class AppState extends ChangeNotifier {
  UserProvider userState = UserProvider();
  SettingsProvider settingsState = SettingsProvider();
  bool testVar = false;

  Future<void> initialize() async {
    int userId = userState.get().id;

    // initialize all of the state
    await settingsState.initialize(userId);
  }

  void setSettings(Settings settings) {
    settingsState.set(settings);
    notifyListeners();
  }

  void setVar(bool boolean) {
    testVar = boolean;
    notifyListeners();
  }
}
