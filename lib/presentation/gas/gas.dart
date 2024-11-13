// ignore_for_file: unused_import

import 'package:energy_dashboard/core/extensions/list_extension.dart';
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
import 'package:energy_dashboard/presentation/gas/blocs/gas_kpi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Gas extends StatefulWidget {
  const Gas({super.key});

  @override
  State<Gas> createState() => _GasState();
}

class _GasState extends State<Gas> {

  late final KPIManager manager;

  @override
  void initState() {
    super.initState();
    context.read<GasKpiBloc>().add(LoadGasKpi());
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
          title: Translations.of(context)!.text('dashboard.gas.context-name'),
          showEditButton: true,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              BlocBuilder<GasKpiBloc, GasKpiState>(
                builder: (context, data) {
                  if (data is GasKpiInitial) {
                    return const KPIGridViewPlaceholder(route: NavigationRoute.gas);
                  } else if (data is GasKpiLoading) {
                    return const KPIGridViewSkeleton(route: NavigationRoute.gas);
                  } else if (data is GasKpiData) {
                    if(data.result.isNotEmpty){
                      return KPIGridView(
                        kpis: data.result,
                        route: NavigationRoute.gas
                      );
                    }else{
                      return const SizedBox();
                    }
                  } else if (data is GasKpiError) {
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