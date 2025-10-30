import 'package:flutter/material.dart';

class L10n {
  static const supportedLocales = [
    Locale('en'),
    Locale('es'),
    Locale('ar'),
  ];

  static const languageNames = {
    'en': 'English',
    'es': 'Español',
    'ar': 'العربية',
  };
}

class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null; // Use system/device locale
    notifyListeners();
  }
}