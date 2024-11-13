import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view_placeholder.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view_skeleton.dart';
import 'package:energy_dashboard/presentation/overview/blocs/overview_kpi/overview_kpi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';


class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {

  late final KPIManager manager;

  @override
  void initState() {
    super.initState();
    context.read<OverviewKpiBloc>().add(LoadOverviewKpi());
    manager = context.read<KPIManager>()..setUnavailable();
    isLoggedIn();
  }

  void isLoggedIn() async{
    await GetIt.I.get<AuthRepository>().isUserSignedIn();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: context.select<KPIManager, bool>((manager) => manager.editorMode) ? false : true,
      onPopInvoked: (_) async {
        if(manager.editorMode){
          manager.discardChanges(context);
        }
      },
      child: Scaffold(
        backgroundColor: ColorPalette.websiteBgColor,
        appBar: const Header(
          title: 'EnergyInfoSwiss',
          showSwissLogo: true,
          showInformation: true,
          showEditButton: true
        ),
        body: SafeArea(
          child: ListView(
            children: [
              BlocBuilder<OverviewKpiBloc, OverviewKpiState>(
                buildWhen: (prev, next) => true,
                builder: (context, data) {
                  if (data is OverviewKpiInitial) {
                    return const KPIGridViewPlaceholder(route: NavigationRoute.overview);
                  } else if (data is OverviewKpiLoading) {
                    return const KPIGridViewSkeleton(route: NavigationRoute.overview);
                  } else if (data is OverviewKpiData) {
                    if(data.result.isNotEmpty){
                      return KPIGridView(
                        kpis: data.result,
                        route: NavigationRoute.overview
                      );
                    }else{
                      return const SizedBox();
                    }
                  } else if (data is OverviewKpiError) {
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
