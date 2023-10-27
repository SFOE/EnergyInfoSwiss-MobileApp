import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BackButtonBfe extends StatelessWidget {
  const BackButtonBfe({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.only(left: Paddings.paddingS),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/app_bar/angle-left.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(ColorPalette.primaryColor, BlendMode.srcIn),
            ),
            Gaps.hSpacingXXS,
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  Translations.of(context)!.text('appbar.back_button.text'),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: ColorPalette.primaryColor
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}
