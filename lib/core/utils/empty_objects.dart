import 'package:energy_dashboard/core/types/kpi_category.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';


/// This class provides empty Objects
///
/// They're mostly used for placeholder and skeleton widgets
class EmptyObjects{

  static KeyPerformanceIndex kpi = KeyPerformanceIndex(
    name: '',
    value: null,
    category: KPICategory.energy,
    route: NavigationRoute.overview,
    position: 0
  );

}