import 'dart:ui';

import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


enum AmpelType{
  energy,
  gas
}

extension AmpelTypeExtension on AmpelType{

  String get jsonKey{
    switch(this){
      case AmpelType.energy:
        return 'ampelStatusStrom';
      case AmpelType.gas:
        return 'ampelStatusGas';
    }
  }

  SvgPicture get icon{
    switch(this){
      case AmpelType.energy:
        return SvgPicture.asset('assets/icons/nav_bar/Energy-fill.svg', width: 23, height: 23, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn));
      case AmpelType.gas:
        return SvgPicture.asset('assets/icons/nav_bar/Gas-fill.svg', width: 23, height: 23, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn));
    }
  }

  Color get iconColor{
    switch(this){
      case AmpelType.energy:
        return ColorPalette.energyIconColor;
      case AmpelType.gas:
        return ColorPalette.gasIconColor;
    }
  }

  static AmpelType typeByJsonKey(String key){
    switch(key){
      case 'ampelStatusStrom':
        return AmpelType.energy;
      case 'ampelStatusGas':
        return AmpelType.gas;
      default:
        throw Exception('[AmpelType] typeByJsonName: Invalid json name: $key');
    }
  }

}