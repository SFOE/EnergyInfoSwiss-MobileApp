import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/core/utils/navigation/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';


initUserAuth() async {
  // check for first use
  await _checkFirstUse();
}

_checkFirstUse() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getBool(Constants.kSharedPrefFirstUseKey) != null){
    Routes.isFirstUse = prefs.getBool(Constants.kSharedPrefFirstUseKey)!;
  }else{
    Routes.isFirstUse = true;
    prefs.setBool(Constants.kSharedPrefFirstUseKey, true);
  }
}