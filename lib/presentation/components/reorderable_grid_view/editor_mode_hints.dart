import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class EditorModeHints extends StatelessWidget {
  final NavigationRoute currentRoute;
  const EditorModeHints({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(Paddings.paddingXXS, Paddings.paddingXXS, Paddings.paddingXXS, Paddings.paddingS),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 11.5, left: 2.5),
                child: SvgPicture.asset('assets/icons/kpi_card/drag-dots.svg', width: 8.5, colorFilter: const ColorFilter.mode(ColorPalette.textColorLight, BlendMode.srcIn)),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  Translations.of(context)!.text('editor-mode.hints.draggable'),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.textColorLight,
                      height: 1.1
                  ),
                ),
              )
            ],
          ),
          Gaps.vSpacingXS,
          if(currentRoute == NavigationRoute.overview)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: Paddings.paddingXS, bottom: Paddings.padding3XS),
                  child: SvgPicture.asset('assets/icons/kpi_card/star-fill.svg', width: 15, colorFilter: const ColorFilter.mode(ColorPalette.textColorLight, BlendMode.srcIn)),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    Translations.of(context)!.text('editor-mode.hints.star'),
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.textColorLight,
                        height: 1.1
                    ),
                  ),
                )
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: Paddings.paddingXS, bottom: Paddings.padding3XS),
                  child: SvgPicture.asset('assets/icons/kpi_card/circle-minus.svg', width: 15, colorFilter: const ColorFilter.mode(ColorPalette.textColorLight, BlendMode.srcIn)),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    Translations.of(context)!.text('editor-mode.hints.hide'),
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.textColorLight,
                        height: 1.1
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
