import 'package:energy_dashboard/core/mixins/kpi_card_mixin.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/kpi_utils.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class KpiCardChart extends StatelessWidget with KPICardMixin {
  final KeyPerformanceIndex kpi;
  const KpiCardChart({super.key, required this.kpi});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: getCardSize(screenWidth, false)/4,
      height: getCardSize(screenWidth, false)/4,
      decoration: BoxDecoration(
        color: ColorPalette.grey100,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(Paddings.paddingXXS),
      child: ColorFiltered(
        colorFilter: kpi.isDisabled
          ? const ColorFilter.mode(ColorPalette.grey100, BlendMode.saturation)
          : const ColorFilter.mode(Colors.transparent, BlendMode.color),
        child: SvgPicture.asset(
          KPIUtils().getChartAssetPathByJsonKey(kpi.name),
        ),
      ),
    );
  }
}
