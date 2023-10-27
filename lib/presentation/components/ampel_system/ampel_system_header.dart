import 'package:energy_dashboard/core/mixins/ampel_system_mixin.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/ampel_level.dart';
import 'package:energy_dashboard/core/types/ampel_type.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/entities/ampel.dart';
import 'package:flutter/material.dart';


class AmpelSystemHeader extends StatelessWidget with AmpelSystemMixin{
  final Ampel ampel;
  final ValueNotifier<bool> isExpanded;
  final VoidCallback toggleCallback;
  const AmpelSystemHeader({super.key, required this.ampel, required this.isExpanded, required this.toggleCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleCallback(),
      child: ValueListenableBuilder(
        valueListenable: isExpanded,
        builder: (context, expanded, child){
          return Container(
            color: ColorPalette.websiteBgColor,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: double.infinity,
              height: AmpelSystemMixin.kAmpelSystemHeight,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: AmpelSystemMixin.kAmpelSystemTabsHeight),
              padding: const EdgeInsets.only(left: Paddings.paddingXS, right: Paddings.paddingS),
              decoration: BoxDecoration(
                borderRadius: expanded ? const BorderRadius.only(topLeft: Radius.circular(AmpelSystemMixin.kAmpelSystemBorderRadius), topRight: Radius.circular(AmpelSystemMixin.kAmpelSystemBorderRadius)) : BorderRadius.circular(AmpelSystemMixin.kAmpelSystemBorderRadius),
                color: ampel.level.ampelSoftColor,
                border: Border.all(width: AmpelSystemMixin.kAmpelSystemBorderWidth, color: ampel.level.ampelColorMedium),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if(ampel.level.warnIcon != null)
                          ampel.level.warnIcon!,
                        ampel.type.icon,
                        Gaps.hSpacingXS,
                        Expanded(
                          child: Text(
                            Translations.of(context)!.text('${getAmpelTranslationKeyPrefix(ampel)}.titel'),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: Paddings.paddingXS),
                    child: expanded ? Icon(Icons.clear_rounded, size: 20, color: ampel.level.ampelColorMedium) : Icon(Icons.info, size: 20, color: ampel.level.ampelColorMedium),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
