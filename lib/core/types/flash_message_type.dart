import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:flutter/material.dart';


enum FlashMessageType{
  success,
  error,
  info
}

extension FlashMessageTypeExtension on FlashMessageType{

  String get iconAssetPath{
    switch(this){
      case FlashMessageType.success:
        return 'assets/icons/flash_message/success.svg';
      case FlashMessageType.error:
        return 'assets/icons/flash_message/error.svg';
      case FlashMessageType.info:
        return 'assets/icons/flash_message/info.svg';
    }
  }

  Color get color{
    switch(this){
      case FlashMessageType.success:
        return ColorPalette.flashMessageSuccessColor;
      case FlashMessageType.error:
        return ColorPalette.flashMessageErrorColor;
      case FlashMessageType.info:
        return ColorPalette.flashMessageInfoColor;
    }
  }

}