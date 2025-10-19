import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeViewModel extends ChangeNotifier {
  static const _boxName = 'settingsBox';
  static const _key = 'isDarkMode';

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeViewModel() {
    _loadTheme();
  }

  void _loadTheme() async {
    final box = await Hive.openBox(_boxName);
    _isDarkMode = box.get(_key, defaultValue: false);
    notifyListeners();
  }

  Future<void> init() async {
    final box = await Hive.openBox(_boxName);
    _isDarkMode = box.get(_key, defaultValue: false);
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final box = await Hive.openBox(_boxName);
    await box.put(_key, _isDarkMode);
    notifyListeners();
  }
}
