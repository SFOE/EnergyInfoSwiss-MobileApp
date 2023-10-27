import 'package:energy_dashboard/app.dart';
import 'package:energy_dashboard/core/utils/details_parameter.dart';
import 'package:energy_dashboard/core/utils/information_details_parameter.dart';
import 'package:energy_dashboard/presentation/auth/login/login.dart';
import 'package:energy_dashboard/presentation/auth/password_reset/password_reset.dart';
import 'package:energy_dashboard/presentation/auth/password_reset/password_reset_confirmation.dart';
import 'package:energy_dashboard/presentation/auth/registration/registration.dart';
import 'package:energy_dashboard/presentation/details/details.dart';
import 'package:energy_dashboard/presentation/energy/energy.dart';
import 'package:energy_dashboard/presentation/gas/gas.dart';
import 'package:energy_dashboard/presentation/information/information.dart';
import 'package:energy_dashboard/presentation/information/information_details/information_details.dart';
import 'package:energy_dashboard/presentation/information/languages/languages.dart';
import 'package:energy_dashboard/presentation/information/privacy_policy/privacy_policy.dart';
import 'package:energy_dashboard/presentation/overview/overview.dart';
import 'package:energy_dashboard/presentation/price/price.dart';
import 'package:energy_dashboard/presentation/weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class Routes{

  ///* INIT GOROUTER *///
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorLoginKey = GlobalKey<NavigatorState>(debugLabel: 'shellLogin');
  static final _shellNavigatorOverviewKey = GlobalKey<NavigatorState>(debugLabel: 'shellOverview');
  static final _shellNavigatorEnergyKey = GlobalKey<NavigatorState>(debugLabel: 'shellEnergy');
  static final _shellNavigatorGasKey = GlobalKey<NavigatorState>(debugLabel: 'shellGas');
  static final _shellNavigatorPriceKey = GlobalKey<NavigatorState>(debugLabel: 'shellPrice');
  static final _shellNavigatorWeatherKey = GlobalKey<NavigatorState>(debugLabel: 'shellWeather');

  // initialized in initUserAuth
  static late final bool isFirstUse;
  //static late final bool _isLoggedIn = true;

  static final GoRouter goRouter = GoRouter(
    initialLocation: isFirstUse ? '/login' : '/overview',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell){
          return App(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorOverviewKey,
            routes: [
              GoRoute(
                path: '/overview',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Overview(),
                ),
                routes: _overviewRoutes,
              )
            ]
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorEnergyKey,
            routes: [
              GoRoute(
                path: '/energy',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Energy(),
                ),
                routes: _energyRoutes,
              )
            ]
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorGasKey,
            routes: [
              GoRoute(
                path: '/gas',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Gas(),
                ),
                routes: _gasRoutes,
              )
            ]
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorPriceKey,
            routes: [
              GoRoute(
                path: '/price',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Price(),
                ),
                routes: _priceRoutes,
              )
            ]
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorWeatherKey,
            routes: [
              GoRoute(
                path: '/weather',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Weather(),
                ),
                routes: _weatherRoutes,
              )
            ]
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorLoginKey,
            routes: [
              GoRoute(
                path: '/login',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Login(),
                ),
                routes: _loginRoutes,
              )
            ]
          ),
        ]
      ),
    ]
  );



  /// Subroutes

  static final List<GoRoute> _loginRoutes = [
    GoRoute(
      path: 'registration',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const Registration(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: 'password_reset',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PasswordReset(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
            child: child,
          );
        },
      ),
      routes: [
        GoRoute(
            path: 'password_reset_confirmation',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const PasswordResetConfirmation(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: animation.drive(Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
                  child: child,
                );
              },
            ),
        ),
      ]
    ),
  ];


  static final List<GoRoute> _overviewRoutes = [
    GoRoute(
      path: 'details',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: Details(detailsParameter: (state.extra as DetailsParameter)),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: 'information',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const Information(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
            child: child,
          );
        },
      ),
      routes: [
        GoRoute(
          path: 'languages',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: Languages(currentLocale: state.extra as Locale),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: 'information_details',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: InformationDetails(detailsParameter: (state.extra as InformationDetailsParameter)),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: 'privacy_policy',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const PrivacyPolicy(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
                child: child,
              );
            },
          ),
        ),
      ]
    ),
  ];


  static final List<GoRoute> _energyRoutes = [
    GoRoute(
      path: 'details',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: Details(detailsParameter: (state.extra as DetailsParameter)),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
            child: child,
          );
        },
      ),
    ),
  ];


  static final List<GoRoute> _gasRoutes = [
    GoRoute(
      path: 'details',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: Details(detailsParameter: (state.extra as DetailsParameter)),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
            child: child,
          );
        },
      ),
    ),
  ];


  static final List<GoRoute> _priceRoutes = [
    GoRoute(
      path: 'details',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: Details(detailsParameter: (state.extra as DetailsParameter)),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
            child: child,
          );
        },
      ),
    ),
  ];


  static final List<GoRoute> _weatherRoutes = [
    GoRoute(
      path: 'details',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: Details(detailsParameter: (state.extra as DetailsParameter)),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart))),
            child: child,
          );
        },
      ),
    ),
  ];

}