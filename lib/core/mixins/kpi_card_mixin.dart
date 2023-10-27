

import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/kpi_utils.dart';
import 'package:energy_dashboard/data/repositories/database_repository.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

mixin KPICardMixin{

  // Constants
  static const double kKpiCardBorderRadius = 14;
  static const double kKpiCardBorderWidth = 1;
  static const double kKpiCardBorderWidthEditorMode = 4;
  static const int kNumberIncreaseDurationMs = 1600;

  // Text styles
  static const TextStyle kValueTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: ColorPalette.textColor,
    height: 0.2,
  );
  static const TextStyle kUnitTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.5,
    color: ColorPalette.textColor,
    textBaseline: TextBaseline.alphabetic,
    height: 1
  );


  /// Functions

  double getCardSize(double screenWidth, bool isExpanded){
    return isExpanded ? screenWidth-2*Paddings.paddingS : (screenWidth-2*Paddings.paddingS-Constants.kGridViewRunSpacing)/2;
  }

  List<KeyPerformanceIndex> initialKPIs(NavigationRoute route){
    List<KeyPerformanceIndex> kpis = GetIt.I.get<DatabaseRepository>().getKPIsByRoute(route);
    if(kpis.isEmpty){
      kpis = KPIUtils.getDefaultKPIsByRoute(route);
    }else{
      kpis.removeWhere((k) => k.isDisabled);
    }
    return kpis;
  }


}