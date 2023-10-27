import 'package:energy_dashboard/core/mixins/header_mixin.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SwissLogo extends StatelessWidget{
  const SwissLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Paddings.paddingS),
      child: SvgPicture.asset(
        'assets/icons/app_bar/bund_ch_flag.svg',
        alignment: Alignment.center,
        width: HeaderMixin.kHeaderLogoWidth,
        height: HeaderMixin.kHeaderLogoHeight,
      ),
    );
  }
}
