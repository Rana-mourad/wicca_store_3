import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    try {
      debugPrint(
          '=============================init Preferences ===================================');
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print('>>> error in config preferences ${e.toString()}');
    }
  }

  static SharedPreferences? get preferences => _prefs;
}
