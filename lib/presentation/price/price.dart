import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view_skeleton.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/kpi_grid_view_placeholder.dart';
import 'package:energy_dashboard/presentation/price/blocs/price_kpi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Price extends StatefulWidget {
  const Price({super.key});

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {

  late final KPIManager manager;

  @override
  void initState() {
    super.initState();
    context.read<PriceKpiBloc>().add(LoadPriceKpi());
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
          title: Translations.of(context)!.text('dashboard.preise.context-name.lang'),
          showEditButton: true,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              BlocBuilder<PriceKpiBloc, PriceKpiState>(
                builder: (context, data) {
                  if (data is PriceKpiInitial) {
                    return const KPIGridViewPlaceholder(route: NavigationRoute.price);
                  } else if (data is PriceKpiLoading) {
                    return const KPIGridViewSkeleton(route: NavigationRoute.price);
                  } else if (data is PriceKpiData) {
                    if(data.result.isNotEmpty){
                      return KPIGridView(
                        kpis: data.result,
                        route: NavigationRoute.price
                      );
                    }else{
                      return const SizedBox();
                    }
                  } else if (data is PriceKpiError) {
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