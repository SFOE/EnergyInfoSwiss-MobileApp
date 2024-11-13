// ignore_for_file: unused_import

import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view_skeleton.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/reorderable_grid_view.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view_placeholder.dart';
import 'package:energy_dashboard/presentation/energy/blocs/energy_kpi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Energy extends StatefulWidget {
  const Energy({super.key});

  @override
  State<Energy> createState() => _EnergyState();
}

class _EnergyState extends State<Energy> {

  late final KPIManager manager;

  @override
  void initState() {
    super.initState();
    context.read<EnergyKpiBloc>().add(LoadEnergyKpi());
    manager = context.read<KPIManager>()..setUnavailable();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(  // PopScope not working properly with GoRouter > 12.0.0
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
          title: Translations.of(context)!.text('dashboard.strom.context-name'),
          showEditButton: true
        ),
        body: SafeArea(
          child: ListView(
            children: [
              BlocBuilder<EnergyKpiBloc, EnergyKpiState>(
                builder: (context, data) {
                  if (data is EnergyKpiInitial) {
                    return const KPIGridViewPlaceholder(route: NavigationRoute.energy);
                  } else if (data is EnergyKpiLoading) {
                    return const KPIGridViewSkeleton(route: NavigationRoute.energy);
                  } else if (data is EnergyKpiData) {
                    if(data.result.isNotEmpty){
                      return KPIGridView(
                        kpis: data.result,
                        route: NavigationRoute.energy
                      );
                    }else{
                      return const SizedBox();
                    }
                  } else if (data is EnergyKpiError) {
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