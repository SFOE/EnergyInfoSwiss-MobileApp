import 'dart:convert';

import 'package:energy_dashboard/core/extensions/string_extension.dart';
import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/core/utils/localization.dart';
import 'package:energy_dashboard/data/repositories/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Translations {
  Translations(this.locale){
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic>? _localizedValues;

  // API translation maps
  static late Map<String, dynamic> apiDE;
  static late Map<String, dynamic> apiEN;
  static late Map<String, dynamic> apiFR;
  static late Map<String, dynamic> apiIT;

  static Translations? of(BuildContext context) => Localizations.of<Translations>(context, Translations);

  String text(String key) {
    if (_localizedValues?.containsKey(key) ?? false) {
      return _localizedValues![key].toString().isEmpty ? key.removeHtmlTags() : _localizedValues![key].toString().removeHtmlTags();
    } else {
      return key.removeHtmlTags();
    }
  }


  // init API translations
  static Future<void> initApiTranslations() async{
    Map<String, dynamic> apiTranslations = await GetIt.I.get<ApiRepository>().getApiTranslations();

    // init all api maps
    try{
      for(var k in apiTranslations.entries){
        switch(k.key.toLowerCase()){
          case 'de':
            apiDE = k.value;
            break;
          case 'en':
            apiEN = k.value;
            break;
          case 'fr':
            apiFR = k.value;
            break;
          case 'it':
            apiIT = k.value;
            break;
        }
      }
    } catch(e){
      throw Exception('[Translations] getApiTranslations: $e');
    }
  }


  static Future<Translations> load(Locale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // store selected language in SP if necessary
    String? storedLanguageCode = prefs.getString(Constants.kSharedPrefLanguageKey);
    if(storedLanguageCode == null){
      prefs.setString(Constants.kSharedPrefLanguageKey, locale.languageCode);
    }else{
      locale = Locale(storedLanguageCode, '');
    }

    // json file paths based on given locale (local and web)
    List<String> translationPaths = [
      'assets/translations/local/${locale.languageCode}.json',
      'assets/translations/local/privacy_policy/${locale.languageCode}.json',
      'assets/translations/web/${locale.languageCode}.json',
    ];

    Translations translations = Translations(locale);

    Map<String, dynamic> mergedTranslations = {};

    // add web and local maps
    for(String filePath in translationPaths){
      mergedTranslations.addAll(
        json.decode(  // create map
          await rootBundle.loadString(filePath) // json content
        )
      );
    }

    // add api map
    mergedTranslations.addAll(_getApiMapByLocale(locale));

    _localizedValues = mergedTranslations;

    return translations;
  }

  get currentLanguage => locale.languageCode;

  // returns the respective apiMap
  static Map<String, dynamic> _getApiMapByLocale(Locale locale){
    switch(locale.languageCode.toLowerCase()){
      case 'de':
        return apiDE;
      case 'en':
        return apiEN;
      case 'fr':
        return apiFR;
      case 'it':
        return apiIT;
      default:
        throw Exception('[Translations] _getApiMapByLocale: Invalid locale provided: $locale');
    }
  }

}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => GetIt.I.get<AppLocalization>().supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}

class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale? overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<Translations> load(Locale locale) => Translations.load(overriddenLocale!);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => true;
}
