import 'package:energy_dashboard/core/mixins/ampel_system_mixin.dart';
import 'package:energy_dashboard/core/types/ampel_level.dart';
import 'package:energy_dashboard/domain/entities/ampel.dart';
import 'package:flutter/material.dart';


class AmpelSystemTabs extends StatelessWidget {
  final Ampel ampel;
  const AmpelSystemTabs({super.key, required this.ampel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AmpelSystemMixin.kAmpelSystemTabsHeight,
      color: Colors.transparent,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(top: AmpelSystemMixin.kAmpelSystemBorderWidth),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for(var l in AmpelLevel.values)...[
            ClipRRect(
              borderRadius: l == AmpelLevel.level1 && l != ampel.level
                  ? const BorderRadius.only(topLeft: Radius.circular(AmpelSystemMixin.kAmpelSystemBorderRadius))
                  : l == AmpelLevel.level5 && l != ampel.level
                  ? const BorderRadius.only(topRight: Radius.circular(AmpelSystemMixin.kAmpelSystemBorderRadius))
                  : const BorderRadius.all(Radius.zero),
              child: Container(
                width: AmpelSystemMixin.kAmpelSystemTabWidth,
                height: l == ampel.level ? AmpelSystemMixin.kAmpelSystemTabHeightActive : AmpelSystemMixin.kAmpelSystemTabHeightInactive,
                margin: l != ampel.level ? const EdgeInsets.only(bottom: AmpelSystemMixin.kAmpelSystemBorderWidth) : null,
                decoration: BoxDecoration(
                  color: l == ampel.level
                    ? l.ampelSoftColor
                    : l.ampelColorTab,
                  border: l == ampel.level
                    ? Border(
                        left: BorderSide(width: AmpelSystemMixin.kAmpelSystemTabsBorderWidth, color: ampel.level.ampelColorMedium),
                        top: BorderSide(width: AmpelSystemMixin.kAmpelSystemTabsBorderWidth, color: ampel.level.ampelColorMedium),
                        right: BorderSide(width: AmpelSystemMixin.kAmpelSystemTabsBorderWidth, color: ampel.level.ampelColorMedium))
                    : null,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
