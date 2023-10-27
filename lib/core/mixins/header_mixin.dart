import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:flutter/cupertino.dart';


mixin HeaderMixin{

  // Constants
  static const double kHeaderLogoWidth = 28.88;
  static const double kHeaderLogoHeight = 33;
  static const double kHeaderCancelButtonWidth = 15;

  double getBackButtonWidthByLangCode(String langCode){
    switch(langCode){
      case 'de':
        return 84.0;
      case 'en':
        return 81.0;
      case 'fr':
        return 84.0;
      case 'it':
        return 87.0;
      default:
        return 82.0;
    }
  }

  double getLeadingWidth(bool showSwissLogo, bool showBackButton, bool isEditing, BuildContext context){
    if(isEditing){
      return 2*Paddings.paddingS+HeaderMixin.kHeaderCancelButtonWidth;
    }else{
      if(showSwissLogo){
        return Paddings.paddingS + kHeaderLogoWidth;
      }else if(showBackButton){
        return Paddings.paddingS + getBackButtonWidthByLangCode(Translations.of(context)!.locale.languageCode);
      }else{
        return 0;
      }
    }
  }

  bool getCenterTitle(bool showSwissLogo, bool isEditing){
    return isEditing ? false : !showSwissLogo;
  }

}