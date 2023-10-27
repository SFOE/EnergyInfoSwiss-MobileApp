import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/core/utils/localization.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/information/languages/languages_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Languages extends StatefulWidget {
  final Locale currentLocale;
  const Languages({super.key, required this.currentLocale});

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  late ValueNotifier<Locale> _currentLocale;

  @override
  void initState() {
    super.initState();
    _currentLocale = ValueNotifier(widget.currentLocale);
  }

  @override
  void dispose() {
    _currentLocale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.grey50,
      appBar: Header(
        title: Translations.of(context)!.text('appbar.title.language'),
        showBackButton: true
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _currentLocale,
          builder: (context, locale, _) {
            return ListView.builder(
              itemCount: GetIt.I.get<AppLocalization>().supportedLanguages.length,
              itemBuilder: (context, index){
                return LanguagesTile(
                  index: index,
                  active: GetIt.I.get<AppLocalization>().supportedLanguages[index] == locale.languageCode,
                  callback: () async => await _changeLanguage(index, context),
                );
              },
            );
          }
        ),
      ),
    );
  }

  Future<void> _changeLanguage(int langIndex, context) async {
    AppLocalization localization = GetIt.I.get<AppLocalization>();
    // set new language globally
    localization.onLocaleChanged(Locale(localization.supportedLanguages[langIndex], ''));
    // update value notifier
    _currentLocale.value = Locale(localization.supportedLanguages[langIndex], '');
    // store new language
    final SharedPreferences _ = await SharedPreferences.getInstance()
      ..setString(Constants.kSharedPrefLanguageKey, localization.supportedLanguages[langIndex]);
  }
}
