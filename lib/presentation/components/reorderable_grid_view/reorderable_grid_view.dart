import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/data/repositories/database_repository.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:energy_dashboard/presentation/components/kpi_card/kpi_card.dart';
import 'package:energy_dashboard/presentation/components/kpi_card/kpi_card_draggable_feedback.dart';
import 'package:energy_dashboard/presentation/components/reorderable_grid_view/editor_mode_hints.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class ReorderableGridView extends StatefulWidget {
  final NavigationRoute route;
  // ignore: prefer_const_constructors_in_immutables
  ReorderableGridView({super.key, required this.route});

  @override
  State<ReorderableGridView> createState() => _ReorderableGridViewState();
}

class _ReorderableGridViewState extends State<ReorderableGridView> {

  late KPIManager manager;
  late DatabaseRepository databaseRepository;

  @override
  void initState() {
    super.initState();
    manager = context.read<KPIManager>();
    databaseRepository = GetIt.I.get<DatabaseRepository>();
  }

  @override
  void dispose() {
    //manager.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Selector<KPIManager, List<KeyPerformanceIndex>>(
        selector: (_, manager) => manager.kpis,
        shouldRebuild: (_,__) => true,
        builder: (context, kpis, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              EditorModeHints(currentRoute: widget.route),
              SizedBox(
                width: double.infinity,
                child: ReorderableWrap(
                  spacing: Constants.kGridViewSpacing,
                  runSpacing: Constants.kGridViewRunSpacing,
                  controller: manager.scrollController,
                  onReorder: (oldIndex, newIndex) => _onReorder(oldIndex, newIndex),
                  enableReorder: true,
                  alignment: WrapAlignment.start,
                  needsLongPressDraggable: true,
                  buildDraggableFeedback: (context, constraints, child) => KpiCardDraggableFeedback(child: child),
                  children: kpis.where((kpi) => !kpi.isDisabled).map((k){
                    return KpiCard(
                      key: Key('${k.name}-${k.category}-reorderable'),
                      kpi: k,
                      currentRoute: widget.route,
                      editorMode: true,
                    );
                  }).toList(),
                ),
              ),
              Gaps.vSpacingL,
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: Constants.kGridViewSpacing,
                  runSpacing: Constants.kGridViewRunSpacing,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: kpis.where((kpi) => kpi.isDisabled).map((k) => KpiCard(
                    key: Key('${k.name}-${k.category}-reorderable'),
                    kpi: k,
                    currentRoute: widget.route,
                    editorMode: true,
                  )).toList(),
                ),
              )
            ],
          );
        }
    );
  }


  _onReorder(int oldIndex, int newIndex){
    // Rebuild widget, Re-set manager kpi list
    setState(() {
      manager.updatePosition(oldIndex, newIndex);
    });
  }


}
