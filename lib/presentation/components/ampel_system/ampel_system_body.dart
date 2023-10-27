import 'package:energy_dashboard/core/mixins/ampel_system_mixin.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/ampel_level.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/core/utils/utils.dart';
import 'package:energy_dashboard/domain/entities/ampel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AmpelSystemBody extends StatelessWidget with AmpelSystemMixin {
  final Ampel ampel;
  final Animation<double> animation;
  const AmpelSystemBody({super.key, required this.ampel, required this.animation});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: AmpelSystemMixin.kAmpelSystemTabsHeight),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AmpelSystemMixin.kAmpelSystemBorderRadius),
          color: ampel.level.ampelSoftColor,
          border: Border.all(width: AmpelSystemMixin.kAmpelSystemBorderWidth, color: ampel.level.ampelColorMedium)
        ),
        padding: const EdgeInsets.only(top: AmpelSystemMixin.kAmpelSystemHeight+Paddings.paddingXS),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Paddings.paddingS, 0, Paddings.paddingS, Paddings.paddingXXS),
              child: Text(Translations.of(context)!.text('${getAmpelTranslationKeyPrefix(ampel)}.kurztext'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(Paddings.paddingS, 0, Paddings.paddingS, Paddings.paddingS),
              child: Text(Translations.of(context)!.text('${getAmpelTranslationKeyPrefix(ampel)}.langtext'), style: const TextStyle(fontSize: 12.8, fontWeight: FontWeight.normal)),
            ),
            Container(
              color: ampel.level.ampelColorHard,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(Paddings.paddingS, Paddings.paddingXS, Paddings.paddingS, Paddings.paddingS),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: Paddings.paddingXS),
                    child: Text(Translations.of(context)!.text('ampel-disclaimer.langtext'), style: const TextStyle(fontSize: 11.2, color: Colors.white, height: 1.25, fontWeight: FontWeight.w300)),
                  ),
                  const Divider(thickness: 1, color: ColorPalette.dividerColor),
                  Padding(
                    padding: const EdgeInsets.only(top: Paddings.paddingXXS, bottom: Paddings.paddingXXS),
                    child: Text(Translations.of(context)!.text('ampel.tooltip.link-teaser'), style: const TextStyle(fontSize: 12, color: ColorPalette.white, fontWeight: FontWeight.w400)),
                  ),
                  GestureDetector(
                    onTap: () => Utils().launchExternalUrl('https://www.bwl.admin.ch/bwl/${Translations.of(context)!.locale.languageCode}/home.html', context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/icons/link.svg', width: 12, height: 12, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                        Gaps.hSpacingXXS,
                        const Text('bwl.admin.ch', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
