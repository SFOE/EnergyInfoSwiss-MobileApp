import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:flutter/cupertino.dart';


class WebBaseHelper{

  String getWebUrl({
    required BuildContext context,
    required String path
  }){
    return '${Constants.kWebBaseUrl}$path?viewtype=app&lng=${Translations.of(context)!.currentLanguage}';
  }

}