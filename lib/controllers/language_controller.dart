
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends ChangeNotifier {
  LanguageController._();
  static final LanguageController instance = LanguageController._();
  static const String _languageKey = 'life_app_language';
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Locale? _locale;
  Locale? get locale => _locale;

  Future<void> load() async {
    final savedLanguage = await _preferences.getString(_languageKey);
    _locale = _parseLocale(savedLanguage);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    if (languageCode.isEmpty) {
      await _preferences.remove(_languageKey);
    } else {
      await _preferences.setString(_languageKey, languageCode);
    }
    _locale = _parseLocale(languageCode);
    notifyListeners();
  }

  Locale? _parseLocale(String? languageCode) {
    switch (languageCode) {
      case 'en': return const Locale('en');
      case 'de': return const Locale('de');
      case 'pt_PT': return const Locale('pt', 'PT');
      case 'es': return const Locale('es');
      case 'fr': return const Locale('fr');
      default: return null;
    }
  }

  String get selectedLanguage {
    final locale = _locale;
    if (locale == null) return '';
    if (locale.languageCode == 'pt') return 'pt_PT';
    return locale.languageCode;
  }
}
