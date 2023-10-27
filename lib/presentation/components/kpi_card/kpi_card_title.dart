import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/kpi_utils.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:flutter/material.dart';


class KpiCardTitle extends StatelessWidget {
  final KeyPerformanceIndex kpi;
  final bool editorMode;
  final NavigationRoute route;
  const KpiCardTitle({super.key, required this.kpi, required this.editorMode, required this.route});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: route != NavigationRoute.overview && !editorMode ? Paddings.paddingM : 0),
      child: Text(
        KPIUtils().getTitleByJsonKey(kpi.name, kpi.category, context),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 14.2, height: 1.3, color: ColorPalette.textColor.withOpacity(kpi.isDisabled ? 0.7 : 1)),
      ),
    );
  }
}
