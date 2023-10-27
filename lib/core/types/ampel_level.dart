import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


// todo level 6 possible? what about alert banner in prototype?
enum AmpelLevel{
  level1,
  level2,
  level3,
  level4,
  level5
}

extension AmpelLevelExtension on AmpelLevel{

  static AmpelLevel getAmpelLevelByInt(int level){
    switch(level){
      case 1:
        return AmpelLevel.level1;
      case 2:
        return AmpelLevel.level2;
      case 3:
        return AmpelLevel.level3;
      case 4:
        return AmpelLevel.level4;
      case 5:
        return AmpelLevel.level5;
      default:
        throw Exception('[AmpelLevelExtension] getAmpelLevelByString: Invalid int level ($level)');
    }
  }

  Widget? get warnIcon{
    switch(this){
      case AmpelLevel.level1:
        return Gaps.hSpacingS;
      case AmpelLevel.level2:
        return Container(
          width: Paddings.paddingL,
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset('assets/icons/ampel_system/Warning.svg', height: 34, colorFilter: ColorFilter.mode(ampelColorHard, BlendMode.srcIn))
        );
      case AmpelLevel.level3:
      case AmpelLevel.level4:
      case AmpelLevel.level5:
       return Container(
         width: Paddings.paddingXL,
         alignment: Alignment.centerLeft,
         child: SvgPicture.asset('assets/icons/ampel_system/Danger.svg', height: 32, colorFilter: ColorFilter.mode(ampelColorHard, BlendMode.srcIn))
       );
    }
  }

  Color get ampelColorMedium{
    switch(this){
      case AmpelLevel.level1:
        return ColorPalette.ampelLevel1Medium;
      case AmpelLevel.level2:
        return ColorPalette.ampelLevel2Medium;
      case AmpelLevel.level3:
        return ColorPalette.ampelLevel3Medium;
      case AmpelLevel.level4:
        return ColorPalette.ampelLevel4Medium;
      case AmpelLevel.level5:
        return ColorPalette.ampelLevel5Medium;
    }
  }

  Color get ampelColorHard{
    switch(this){
      case AmpelLevel.level1:
        return ColorPalette.ampelLevel1Hard;
      case AmpelLevel.level2:
        return ColorPalette.ampelLevel2Hard;
      case AmpelLevel.level3:
        return ColorPalette.ampelLevel3Hard;
      case AmpelLevel.level4:
        return ColorPalette.ampelLevel4Hard;
      case AmpelLevel.level5:
        return ColorPalette.ampelLevel5Hard;
    }
  }

  Color get ampelColorTab{
    switch(this){
      case AmpelLevel.level1:
        return ColorPalette.ampelLevel1Tab;
      case AmpelLevel.level2:
        return ColorPalette.ampelLevel2Tab;
      case AmpelLevel.level3:
        return ColorPalette.ampelLevel3Tab;
      case AmpelLevel.level4:
        return ColorPalette.ampelLevel4Tab;
      case AmpelLevel.level5:
        return ColorPalette.ampelLevel5Tab;
    }
  }

  Color get ampelSoftColor{
    switch(this){
      case AmpelLevel.level1:
        return ColorPalette.ampelLevel1Soft;
      case AmpelLevel.level2:
        return ColorPalette.ampelLevel2Soft;
      case AmpelLevel.level3:
        return ColorPalette.ampelLevel3Soft;
      case AmpelLevel.level4:
        return ColorPalette.ampelLevel4Soft;
      case AmpelLevel.level5:
        return ColorPalette.ampelLevel5Soft;
    }
  }

}