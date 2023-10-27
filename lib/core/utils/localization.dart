import 'package:energy_dashboard/core/resources/callbacks.dart';
import 'package:flutter/material.dart';


class AppLocalization {
  // List of supported languages
  final List<String> supportedLanguages = ['de', 'fr', 'en', 'it'];

  // Returns the list of supported Locales
  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  // Function to be invoked when changing the working language
  late LocaleChangeCallback onLocaleChanged;

  ///
  /// Internals
  ///
  static final AppLocalization _appLocalization = AppLocalization._internal();

  factory AppLocalization() => _appLocalization;

  AppLocalization._internal();
}