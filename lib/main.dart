import 'package:energy_dashboard/core/init/init_di.dart';
import 'package:energy_dashboard/core/init/init_user_auth.dart';
import 'package:energy_dashboard/core/utils/localization.dart';
import 'package:energy_dashboard/core/utils/navigation/routes.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/data/repositories/database_repository.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

// ignore_for_file: prefer_const_constructors

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  await initUserAuth();
  await GetIt.I.get<DatabaseRepository>().initDatabase();
  await GetIt.I.get<AuthRepository>().initAmplify();
  await Translations.initApiTranslations(); // todo handle offline mode (or slow internet connection)
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(EnergyDashboard());
}

class EnergyDashboard extends StatefulWidget {
  const EnergyDashboard({super.key});

  @override
  State<EnergyDashboard> createState() => _EnergyDashboardState();
}

class _EnergyDashboardState extends State<EnergyDashboard> {

  late SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();
    _localeOverrideDelegate = SpecificLocalizationDelegate(null);

    ///
    /// Let's save a pointer to this method, should the user wants to change its language
    /// We would then call: localization.onLocaleChanged(Locale('en',''));
    ///
    GetIt.I.get<AppLocalization>().onLocaleChanged = onLocaleChange;

  }

  // rebuild app on language change
  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: GetIt.I.get<AppLocalization>().supportedLocales(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showPerformanceOverlay: false,
      theme: ThemeData(
        fontFamily: 'FrutigerLT',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      routerConfig: Routes.goRouter,
    );
  }
}