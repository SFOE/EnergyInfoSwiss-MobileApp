import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:energy_dashboard/presentation/components/kpi_card/kpi_card.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/reorderable_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class KPIGridView extends StatelessWidget {
  final List<KeyPerformanceIndex> kpis;
  final NavigationRoute route;
  const KPIGridView({super.key, required this.kpis, required this.route});

  @override
  Widget build(BuildContext context) {
    context.read<KPIManager>().setAvailable();
    return Padding(
      padding: const EdgeInsets.all(Paddings.paddingS),
      child: Selector<KPIManager, bool>(
        selector: (_, manager) => manager.editorMode,
        builder: (_, isEditing, __){
          if(isEditing){
            return ReorderableGridView(route: route);
          }else{
            return Wrap(
              spacing: Constants.kGridViewSpacing,
              runSpacing: Constants.kGridViewRunSpacing,
              alignment: WrapAlignment.start,
              children: kpis.where((k) => !k.isDisabled).map((k) => KpiCard(
                key: Key('${k.name}-${k.category}'),
                kpi: k,
                currentRoute: route,
                editorMode: false,
              )).toList(),
            );
          }
        },
      ),
    );
  }
}
