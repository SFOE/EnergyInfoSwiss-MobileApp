import 'package:energy_dashboard/core/mixins/kpi_card_mixin.dart';
import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';


/// This is the placeholder widget for the KPI Grid View
///
/// It is shown while the blocbuilder state is Initial
/// It creates a placeholder for each KPI tile
class KPIGridViewPlaceholder extends StatelessWidget with KPICardMixin{
  final NavigationRoute route;
  const KPIGridViewPlaceholder({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(Paddings.paddingS),
      child: AbsorbPointer(
        absorbing: true,
        child: ReorderableWrap(
          spacing: Constants.kGridViewSpacing,
          runSpacing: Constants.kGridViewRunSpacing,
          onReorder: (_, __){},
          enableReorder: false,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          children: initialKPIs(route).map((k) => SizedBox(
            width: getCardSize(screenWidth, false),
            height: getCardSize(screenWidth, false)
          )).toList(),
        ),
      ),
    );
  }
}
