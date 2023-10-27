import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class KpiCardEditorRow extends StatelessWidget {
  final NavigationRoute route;
  final KeyPerformanceIndex kpi;
  final VoidCallback fadeCallback;
  const KpiCardEditorRow({super.key, required this.kpi, required this.route, required this.fadeCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Paddings.paddingXXS),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 23),
          if(!kpi.isDisabled)
            SvgPicture.asset('assets/icons/kpi_card/drag-dots.svg', width: 23, height: 23, colorFilter: const ColorFilter.mode(ColorPalette.textColorLight, BlendMode.srcIn)),
          if(kpi.route == NavigationRoute.overview)
            GestureDetector(
              child: SvgPicture.asset(
                kpi.route == NavigationRoute.overview
                  ? 'assets/icons/kpi_card/star-fill.svg'
                  : 'assets/icons/kpi_card/star-outline.svg',
                width: Constants.kStarIconSize,
                height: Constants.kStarIconSize,
                colorFilter: const ColorFilter.mode(ColorPalette.kpiCardStarColor, BlendMode.srcIn)
              ),
              onTap: () => fadeCallback(),
            )
          else
            GestureDetector(
              child: SvgPicture.asset(kpi.isDisabled ? 'assets/icons/kpi_card/circle-plus.svg' : 'assets/icons/kpi_card/circle-minus.svg', width: 21, height: 21, colorFilter: const ColorFilter.mode(ColorPalette.primaryColor, BlendMode.srcIn)),
              onTap: () => fadeCallback(),
            ),
        ],
      ),
    );
  }
}
