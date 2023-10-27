import 'dart:ui';

import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:hive/hive.dart';

part 'kpi_category.g.dart';

@HiveType(typeId: 1)
enum KPICategory{
  @HiveField(0)
  energy,
  @HiveField(1)
  gas,
  @HiveField(2)
  price,
  @HiveField(3)
  weather
}


extension KPICategoryExtension on KPICategory{

  String get title => toString().replaceAll('NavigationCategory.', '');

  String get iconAssetPath{
    switch(this){
      case KPICategory.energy:
        return 'assets/icons/nav_bar/Energy-fill.svg';
      case KPICategory.gas:
        return 'assets/icons/nav_bar/Gas-fill.svg';
      case KPICategory.price:
        return 'assets/icons/nav_bar/Price-Trend-fill.svg';
      case KPICategory.weather:
        return 'assets/icons/nav_bar/Weather-fill.svg';
    }
  }

  Color get iconColor{
    switch(this){
      case KPICategory.energy:
        return ColorPalette.energyIconColor;
      case KPICategory.gas:
        return ColorPalette.gasIconColor;
      case KPICategory.price:
        return ColorPalette.priceIconColor;
      case KPICategory.weather:
        return ColorPalette.weatherIconColor;
    }
  }

  NavigationRoute get toRoute{
    switch(this){
      case KPICategory.energy:
        return NavigationRoute.energy;
      case KPICategory.gas:
        return NavigationRoute.gas;
      case KPICategory.price:
        return NavigationRoute.price;
      case KPICategory.weather:
        return NavigationRoute.weather;
    }
  }

}


