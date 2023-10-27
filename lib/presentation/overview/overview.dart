import 'package:energy_dashboard/core/extensions/list_extension.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:energy_dashboard/presentation/components/ampel_system/ampel_system.dart';
import 'package:energy_dashboard/presentation/components/ampel_system/ampel_system_placeholder.dart';
import 'package:energy_dashboard/presentation/components/ampel_system/ampel_system_skeleton.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view_placeholder.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view_skeleton.dart';
import 'package:energy_dashboard/presentation/overview/blocs/ampel/ampel_bloc.dart';
import 'package:energy_dashboard/presentation/overview/blocs/overview_kpi/overview_kpi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';


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
    context.read<AmpelBloc>().add(LoadAmpel());
    context.read<OverviewKpiBloc>().add(LoadOverviewKpi());
    manager = context.read<KPIManager>()..setUnavailable();
    isLoggedIn();
  }

  void isLoggedIn() async{
    await GetIt.I.get<AuthRepository>().isUserSignedIn();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(manager.editorMode){
          manager.discardChanges(context);
          return false;
        }
        return true;
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
              Selector<KPIManager, bool>(
                selector: (_, manager) => manager.editorMode,
                builder: (context, edit, _) {
                  return BlocBuilder<AmpelBloc, AmpelState>(
                    builder: (context, data) {
                      if (data is AmpelInitial) {
                        return const AmpelSystemPlaceholder();
                      } else if (data is AmpelLoading) {
                        return const AmpelSystemSkeleton();
                      } else if (data is AmpelData) {
                        if(data.result.isNotEmpty && !edit){
                          return AmpelSystem(ampel: data.result.first);
                          //return AmpelSystem(ampel: Ampel(type: AmpelType.strom, level: AmpelLevel.level5, validFrom: 'validFrom'));
                        }else{
                          return const SizedBox();
                        }
                      } else if (data is AmpelError) {
                        return const SizedBox(); //todo handle error case in all BlocBuilders
                      }
                      return const AmpelSystemPlaceholder();
                    },
                  );
                }
              ),
              Selector<KPIManager, bool>(
                selector: (_, manager) => manager.editorMode,
                builder: (context, edit, _) {
                  return BlocBuilder<AmpelBloc, AmpelState>(
                    builder: (context, data) {
                      if (data is AmpelInitial) {
                        return const AmpelSystemPlaceholder();
                      } else if (data is AmpelLoading) {
                        return const AmpelSystemSkeleton();
                      } else if (data is AmpelData) {
                        if(data.result.isNotEmpty && !edit){
                          return AmpelSystem(ampel: data.result.second!);
                        }else{
                          return const SizedBox();
                        }
                      } else if (data is AmpelError) {
                        return const SizedBox();
                      }
                      return const AmpelSystemPlaceholder();
                    },
                  );
                }
              ),
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
