import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view_skeleton.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view_placeholder.dart';
import 'package:energy_dashboard/presentation/weather/blocs/weather_kpi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  late final KPIManager manager;

  @override
  void initState() {
    super.initState();
    context.read<WeatherKpiBloc>().add(LoadWeatherKpi());
    manager = context.read<KPIManager>()..setUnavailable();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if(manager.editorMode){
          manager.discardChanges(context);
        }else{
          Navigation.goToOverview();
        }
      },
      child: Scaffold(
        backgroundColor: ColorPalette.websiteBgColor,
        appBar: Header(
          title: Translations.of(context)!.text('dashboard.wetter.context-name'),
          showEditButton: true,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              BlocBuilder<WeatherKpiBloc, WeatherKpiState>(
                builder: (context, data) {
                  if (data is WeatherKpiInitial) {
                    return const KPIGridViewPlaceholder(route: NavigationRoute.weather);
                  } else if (data is WeatherKpiLoading) {
                    return const KPIGridViewSkeleton(route: NavigationRoute.weather);
                  } else if (data is WeatherKpiData) {
                    if(data.result.isNotEmpty){
                      return KPIGridView(
                        kpis: data.result,
                        route: NavigationRoute.weather
                      );
                    }else{
                      return const SizedBox();
                    }
                  } else if (data is WeatherKpiError) {
                    return const SizedBox();
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}