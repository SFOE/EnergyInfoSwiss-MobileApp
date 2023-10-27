import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/details_parameter.dart';
import 'package:energy_dashboard/core/utils/information_details_parameter.dart';
import 'package:energy_dashboard/core/utils/navigation/routes.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:get_it/get_it.dart';


/// Utility methods that are used for navigation
///
/// Contains all routing methods
class Navigation {

  ///* NAVIGATION METHODS *///

  static goToInformation(){
    Routes.goRouter.go('/overview/information');
  }

  static goToInformationDetails(InformationDetailsParameter extra){
    Routes.goRouter.go('/overview/information/information_details', extra: extra);
  }

  static goToOverview(){
    Routes.goRouter.go('/overview');
    GetIt.I.get<KPIManager>().updateRoute(NavigationRoute.overview);
  }

  static goToDetails(NavigationRoute route, DetailsParameter extra){
    Routes.goRouter.go('/${route.routingTitle}/details', extra: extra);
  }

  static goToLanguages(context){
    Routes.goRouter.go('/overview/information/languages', extra: Translations.of(context)?.locale);
  }

  static goToPrivacyPolicy(){
    Routes.goRouter.go('/overview/information/privacy_policy');
  }


  // Auth

  static goToRegistration() {
    Routes.goRouter.go('/login/registration');
  }

  static goToLogin(){
    Routes.goRouter.go('/login');
  }

  static goToPwReset(){
    Routes.goRouter.go('/login/password_reset');
  }

  static goToPwResetConfirmation(){
    Routes.goRouter.go('/login/password_reset/password_reset_confirmation');
  }

  /// Unused
  static goToProfile(){
    Routes.goRouter.go('/overview/information/profile');
  }


  /// Unused
  static goToUpdatePassword(){
    Routes.goRouter.go('/overview/information/profile/update_password');
  }


  /// Unused
  static goToUpdateEmail(){
    Routes.goRouter.go('/overview/information/profile/update_email');
  }

  static isDetailsPage(String location){
    return location.contains('/details');
  }

  static finishOnBoarding() async {
    Routes.goRouter.go('/overview');
    GetIt.I.get<AuthRepository>().setFirstUse(false);
  }

  static isNavBarPage(String location){
    if(
      location.contains('/information') ||
      location.contains('/onboarding') ||
      location.contains('/login') ||
      location.contains('/registration') ||
      location.contains('/password_reset') ||
      location.contains('/profile')
    ){
      return false;
    }
    return true;
  }

  // for the default screens (in nav bar)
  static goToRouteByIndex(int index){
    switch (index) {
      case 0:
        Routes.goRouter.go(NavigationRoute.overview.path);
        break;
      case 1:
        Routes.goRouter.go(NavigationRoute.energy.path);
        break;
      case 2:
        Routes.goRouter.go(NavigationRoute.gas.path);
        break;
      case 3:
        Routes.goRouter.go(NavigationRoute.price.path);
        break;
      case 4:
        Routes.goRouter.go(NavigationRoute.weather.path);
        break;
      default:
        throw ArgumentError('Invalid index');
    }
  }

}