import 'package:energy_dashboard/presentation/gas/gas.dart';
import 'package:energy_dashboard/presentation/overview/overview.dart';
import 'package:energy_dashboard/presentation/energy/energy.dart';
import 'package:energy_dashboard/presentation/price/price.dart';
import 'package:energy_dashboard/presentation/weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'navigation_route.g.dart';

@HiveType(typeId: 4)
enum NavigationRoute{
  @HiveField(0)
  overview,
  @HiveField(1)
  energy,
  @HiveField(2)
  gas,
  @HiveField(3)
  price,
  @HiveField(4)
  weather
}


extension NavigationRouteExtension on NavigationRoute{

  String get routingTitle => toString().replaceAll('NavigationRoute.', '');

  int get index{
    switch(this){
      case NavigationRoute.overview:
        return 0;
      case NavigationRoute.energy:
        return 1;
      case NavigationRoute.gas:
        return 2;
      case NavigationRoute.price:
        return 3;
      case NavigationRoute.weather:
        return 4;
    }
  }


  static NavigationRoute getRouteByIndex(int index) {
    switch (index) {
      case 0:
        return NavigationRoute.overview;
      case 1:
        return NavigationRoute.energy;
      case 2:
        return NavigationRoute.gas;
      case 3:
        return NavigationRoute.price;
      case 4:
        return NavigationRoute.weather;
      default:
        throw ArgumentError('Invalid index');
    }
  }

  Widget get page{
    switch(this){
      case NavigationRoute.overview:
        return const Overview();
      case NavigationRoute.energy:
        return const Energy();
      case NavigationRoute.gas:
        return const Gas();
      case NavigationRoute.price:
        return const Price();
      case NavigationRoute.weather:
        return const Weather();
    }
  }

  String get path{
    switch(this){
      case NavigationRoute.overview:
        return '/overview';
      case NavigationRoute.energy:
        return '/energy';
      case NavigationRoute.gas:
        return '/gas';
      case NavigationRoute.price:
        return '/price';
      case NavigationRoute.weather:
        return '/weather';
    }
  }

}

// used for pw reset, registration and login
// because these scenarios will redirect to different paths
enum RedirectionRoute{
  overview,
  onBoardingLogin,
  profile,
  benefitsLogin,
}

// used for pw reset, registration and login
// because these scenarios can be triggered in different base routes
enum PasswordResetMainRoute{
  onBoarding,
  profile,
  benefits
}

enum LoginMainRoute{
  onBoarding,
  benefits
}

enum RegistrationMainRoute{
  onBoarding,
  benefits
}

extension RedirectionRouteExtension on RedirectionRoute{

  String get path{
    switch(this){
      case RedirectionRoute.overview:
        return '/overview';
      case RedirectionRoute.onBoardingLogin:
        return '/onboarding/login';
      case RedirectionRoute.profile:
        return '/overview/information/profile';
      case RedirectionRoute.benefitsLogin:
        return '/overview/information/benefits/login';
    }
  }
}

extension PasswordResetMainRouteExtension on PasswordResetMainRoute{
  String get path{
    switch(this){
      case PasswordResetMainRoute.onBoarding:
        return '/onboarding/login';
      case PasswordResetMainRoute.profile:
        return '/overview/information/profile/update_password';
      case PasswordResetMainRoute.benefits:
        return '/overview/information/benefits/login';
    }
  }
}

extension LoginMainRouteExtension on LoginMainRoute{
  String get path{
    switch(this){
      case LoginMainRoute.onBoarding:
        return '/onboarding';
      case LoginMainRoute.benefits:
        return '/overview/information/benefits';
    }
  }
}

extension RegistrationMainRouteExtension on RegistrationMainRoute{
  String get path{
    switch(this){
      case RegistrationMainRoute.onBoarding:
        return '/onboarding';
      case RegistrationMainRoute.benefits:
        return '/overview/information/benefits';
    }
  }
}