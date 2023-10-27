import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class InformationTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isLink;
  final VoidCallback callback;

  const InformationTile({super.key, required this.title, this.subtitle, required this.isLink, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: Constants.kInformationTileHeight,
        color: ColorPalette.white,
        padding: const EdgeInsets.symmetric(vertical: Paddings.paddingXS, horizontal: Paddings.paddingS),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15.6,
                      color: ColorPalette.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if(subtitle!=null)
                    Padding(
                      padding: const EdgeInsets.only(top: Paddings.paddingXXS),
                      child: Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13.8,
                          color: ColorPalette.textColorLight,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: Paddings.paddingS),
              child: SvgPicture.asset(
                'assets/icons/${isLink ? 'link' : 'chevron-right'}.svg',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(ColorPalette.textColorLight, BlendMode.srcIn),
              ),
            )
          ],
        ),
      ),
      onTap: () => callback(),
    );
  }
}
