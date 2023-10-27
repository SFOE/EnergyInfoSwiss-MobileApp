import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';


class HeaderTitle extends StatelessWidget {
  final String title;
  final bool isEditing;
  const HeaderTitle({super.key, required this.title, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    if(isEditing){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Paddings.paddingS),
        child: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: ColorPalette.textColor,
          ),
          textAlign: TextAlign.start,
        ),
      );
    }else{
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Paddings.paddingXS),
        child: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16.4,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textColor,
          ),
          textAlign: TextAlign.start,
        ),
      );
    }
  }
}
