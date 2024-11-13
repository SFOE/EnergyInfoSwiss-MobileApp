import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:energy_dashboard/domain/services/login_service.dart';
import 'package:energy_dashboard/domain/services/password_service.dart';
import 'package:energy_dashboard/domain/services/registration_service.dart';
import 'package:energy_dashboard/presentation/components/animations/stretchy_scroll_behavior.dart';
import 'package:energy_dashboard/presentation/components/nav_bar/nav_bar.dart';
import 'package:energy_dashboard/presentation/energy/blocs/energy_kpi_bloc.dart';
import 'package:energy_dashboard/presentation/gas/blocs/gas_kpi_bloc.dart';
import 'package:energy_dashboard/presentation/overview/blocs/overview_kpi/overview_kpi_bloc.dart';
import 'package:energy_dashboard/presentation/price/blocs/price_kpi_bloc.dart';
import 'package:energy_dashboard/presentation/weather/blocs/weather_kpi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class App extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const App({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final String currentLocation = navigationShell.shellRouteContext.routeMatchList.fullPath;
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => EnergyKpiBloc()),
        BlocProvider(create: (context) => GasKpiBloc()),
        BlocProvider(create: (context) => PriceKpiBloc()),
        BlocProvider(create: (context) => WeatherKpiBloc()),
        BlocProvider(create: (context) => OverviewKpiBloc()),
        ChangeNotifierProvider(create: (context) => KPIManager()),
        ChangeNotifierProvider(create: (context) => LoginService()),
        ChangeNotifierProvider(create: (context) => PasswordService()),
        ChangeNotifierProvider(create: (context) => RegistrationService()),
      ],
      child: ScrollConfiguration(
        behavior: const StretchyScrollBehavior(direction: AxisDirection.down),
        child: Scaffold(
          body: navigationShell,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Navigation.isNavBarPage(currentLocation) ? NavBar(navigationShell: navigationShell) : null,
        ),
      ),
    );
  }
}
