import 'package:energy_dashboard/core/mixins/kpi_card_mixin.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/utils/kpi_utils.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:energy_dashboard/presentation/components/animations/animated_number_increase.dart';
import 'package:flutter/material.dart';


class KpiCardValue extends StatelessWidget {
  final KeyPerformanceIndex kpi;
  const KpiCardValue({super.key, required this.kpi});

  @override
  Widget build(BuildContext context) {
    final String unit = KPIUtils().getValueUnitByJsonKey(kpi.name);
    // short units -> Row
    if(unit.length <= 3){
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedNumberIncrease(
            start: double.parse(kpi.value ?? '0'),
            end: double.parse(kpi.value ?? '0'),
            duration: const Duration(seconds: 2),
            isDisabled: kpi.isDisabled,
          ),
          Gaps.hSpacing3XS,
          Text(
            KPIUtils().getValueUnitByJsonKey(kpi.name),
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: KPICardMixin.kUnitTextStyle.copyWith(color: ColorPalette.textColor.withOpacity(kpi.isDisabled ? 0.7 : 1))
          ),
        ],
      );
    }
    // Long units -> Column
    else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedNumberIncrease(
            start: double.parse(kpi.value  ?? '0'),
            end: double.parse(kpi.value  ?? '0'),
            isDisabled: kpi.isDisabled,
          ),
          Gaps.vSpacingXXS,
          Text(
            KPIUtils().getValueUnitByJsonKey(kpi.name),
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: KPICardMixin.kUnitTextStyle.copyWith(color: ColorPalette.textColor.withOpacity(kpi.isDisabled ? 0.7 : 1))
          ),
        ],
      );
    }

  }
}
