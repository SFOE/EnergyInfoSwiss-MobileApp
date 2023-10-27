import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:flutter/cupertino.dart';


abstract class DatabaseRepositoryAbstraction{

  Future<void> initDatabase();

  List<KeyPerformanceIndex> getAllKPIs();

  List<KeyPerformanceIndex> getEnergyKPIs();
  List<KeyPerformanceIndex> getGasKPIs();
  List<KeyPerformanceIndex> getPriceKPIs();
  List<KeyPerformanceIndex> getWeatherKPIs();
  List<KeyPerformanceIndex> getOverviewKPIs();

  List<KeyPerformanceIndex> getKPIsByRoute(NavigationRoute route);

  Future<void> storeKPIs(List<KeyPerformanceIndex> kpis);

  void saveChanges(List<KeyPerformanceIndex> kpis, NavigationRoute route, BuildContext context);

  void addFavorite(KeyPerformanceIndex kpi, BuildContext context);
  void removeFavorite(KeyPerformanceIndex kpi, BuildContext context);

  bool isFavorite(KeyPerformanceIndex kpi);

  void removeUnmappedKPIs();
  void getUnmappedKPIs();

}