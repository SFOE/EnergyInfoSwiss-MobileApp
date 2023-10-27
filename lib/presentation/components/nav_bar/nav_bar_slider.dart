import 'package:energy_dashboard/core/mixins/nav_bar_mixin.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';


class NavBarSlider extends StatelessWidget with NavBarMixin {
  final int index;
  const NavBarSlider({super.key, required this.index});


  @override
  Widget build(BuildContext context) {
    double navBarItemWidth = (MediaQuery.of(context).size.width-2*Paddings.paddingS)/5;

    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: NavBarMixin.sliderAnimationDuration),
          curve: Curves.easeOutQuad,
          left: getSliderPosition(index, navBarItemWidth, NavBarMixin.sliderPadding),
          top: 0,
          child: Container(
            width: navBarItemWidth-NavBarMixin.sliderPadding,
            height: 2,
            color: ColorPalette.primaryColor,
          ),
        ),
      ],
    );
  }


}
