import 'package:energy_dashboard/core/types/kpi_category.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/types/trend.dart';
import 'package:energy_dashboard/core/types/trend_rating.dart';
import 'package:energy_dashboard/core/utils/empty_objects.dart';
import 'package:energy_dashboard/core/utils/kpi_utils.dart';
import 'package:energy_dashboard/domain/abstractions/database_repository_abstraction.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:energy_dashboard/presentation/energy/blocs/energy_kpi_bloc.dart';
import 'package:energy_dashboard/presentation/gas/blocs/gas_kpi_bloc.dart';
import 'package:energy_dashboard/presentation/overview/blocs/overview_kpi/overview_kpi_bloc.dart';
import 'package:energy_dashboard/presentation/price/blocs/price_kpi_bloc.dart';
import 'package:energy_dashboard/presentation/weather/blocs/weather_kpi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

/// Repository for database (hive) operations
///
/// Contains all necessary crud methods
/// to manage the database and its content (kpis)
class DatabaseRepository extends DatabaseRepositoryAbstraction{

  late Box<KeyPerformanceIndex> kpiBox;

  @override
  Future<void> initDatabase() async {
    await Hive.initFlutter();
    
    Hive
      ..registerAdapter(KeyPerformanceIndexAdapter())
      ..registerAdapter(NavigationRouteAdapter())
      ..registerAdapter(KPICategoryAdapter())
      ..registerAdapter(TrendAdapter())
      ..registerAdapter(TrendRatingAdapter());

    kpiBox = await Hive.openBox<KeyPerformanceIndex>('kpiBox');

    // check for unmapped (deleted) KPIs in db
    removeUnmappedKPIs();

    //kpiBox.clear();
    debugPrint('stored kpis: ${kpiBox.values.length}');
  }



  @override
  List<KeyPerformanceIndex> getAllKPIs() {
    return kpiBox.values.toList();
  }

  @override
  Future<void> storeKPIs(List<KeyPerformanceIndex> kpis) async {
    for(var kpi in kpis){
      final existingKPI = kpiBox.values.firstWhere(
        (k) => k.name == kpi.name && k.category == kpi.category && kpi.route == k.route,
        orElse: () => EmptyObjects.kpi
      );
      // store new KPI
      if(existingKPI == EmptyObjects.kpi){
        int length = getKPIsByRoute(kpi.route).length;
        kpiBox.add(kpi.copyWith(position: length));
      }
      // update existing KPI (except personalization values)
      else{
        kpiBox.put(existingKPI.key, existingKPI.copyWith(
          isExpanded: existingKPI.isExpanded,
          isDisabled: existingKPI.isDisabled,
          position: existingKPI.position,
          date: kpi.date,
          trend: kpi.trend,
          trendRating: kpi.trendRating,
          value: kpi.value
        ));
      }
    }
  }


  @override
  List<KeyPerformanceIndex> getEnergyKPIs() {
    return kpiBox.values
      .where((k) => k.category == KPICategory.energy && k.route == NavigationRoute.energy)
      .toList()
      ..sort((a, b) => a.position.compareTo(b.position));
  }

  @override
  List<KeyPerformanceIndex> getGasKPIs() {
    return kpiBox.values
      .where((k) => k.category == KPICategory.gas &&  k.route == NavigationRoute.gas)
      .toList()
      ..sort((a, b) => a.position.compareTo(b.position));
  }


  @override
  List<KeyPerformanceIndex> getPriceKPIs() {
    return kpiBox.values
      .where((k) => k.category == KPICategory.price &&  k.route == NavigationRoute.price)
      .toList()
      ..sort((a, b) => a.position.compareTo(b.position));
  }

  @override
  List<KeyPerformanceIndex> getWeatherKPIs() {
    return kpiBox.values
      .where((k) => k.category == KPICategory.weather &&  k.route == NavigationRoute.weather)
      .toList()
      ..sort((a, b) => a.position.compareTo(b.position));
  }

  @override
  List<KeyPerformanceIndex> getOverviewKPIs() {
    List<KeyPerformanceIndex> overviewKpis =  kpiBox.values
      .where((k) =>  k.route == NavigationRoute.overview)
      .toList()
      ..sort((a, b) => a.position.compareTo(b.position));

    return overviewKpis;
  }

  @override
  List<KeyPerformanceIndex> getKPIsByRoute(NavigationRoute route) {
    switch(route){
      case NavigationRoute.overview:
        return getOverviewKPIs();
      case NavigationRoute.energy:
        return getEnergyKPIs();
      case NavigationRoute.gas:
        return getGasKPIs();
      case NavigationRoute.price:
        return getPriceKPIs();
      case NavigationRoute.weather:
        return getWeatherKPIs();
    }
  }



  @override
  void saveChanges(List<KeyPerformanceIndex> kpis, NavigationRoute route, BuildContext context) {

    // Add or update elements
    for (var kpi in kpis) {
      // find the corresponding KPI in the box by key
      final existingKPI = kpiBox.values.firstWhere((k) => k.name == kpi.name && k.category == kpi.category && k.route == kpi.route, orElse: () => EmptyObjects.kpi);

      // Update KPI
      if (existingKPI != EmptyObjects.kpi) {

        // update the existing KPI with the new values
        existingKPI.route = kpi.route;
        existingKPI.isExpanded = kpi.isExpanded;
        existingKPI.isDisabled = kpi.isDisabled;
        existingKPI.position = kpi.position;

        // save the updated KPI back to the box
        existingKPI.save();
      }else{
        // add missing KPI
        kpiBox.add(kpi);
      }
    }

    // Remove elements (unset favorite)
    if(route == NavigationRoute.overview && kpis.length != getOverviewKPIs().length){
      List<dynamic> deletionKeys = [];
      for(var dbKpi in getOverviewKPIs()){
        if(!kpis.contains(dbKpi)){
          deletionKeys.add(dbKpi.key);
        }
      }
      kpiBox.deleteAll(deletionKeys);
    }

    // reload kpis by route
    _loadKpiBlocByRoute(route, context);
  }

  void _loadKpiBlocByRoute(NavigationRoute route, BuildContext context){
    switch(route){
      case NavigationRoute.overview:
        context.read<OverviewKpiBloc>().add(UpdateOverviewKpi());
        break;
      case NavigationRoute.energy:
        context.read<EnergyKpiBloc>().add(UpdateEnergyKpi());
        break;
      case NavigationRoute.gas:
        context.read<GasKpiBloc>().add(UpdateGasKpi());
        break;
      case NavigationRoute.price:
        context.read<PriceKpiBloc>().add(UpdatePriceKpi());
        break;
      case NavigationRoute.weather:
        context.read<WeatherKpiBloc>().add(UpdateWeatherKpi());
        break;
    }
  }

  @override
  void addFavorite(KeyPerformanceIndex kpi, BuildContext context) {
    for(var k in getOverviewKPIs()){
      k.position++;
      k.save();
    }
    final KeyPerformanceIndex newFavorite = kpi.copyWith(route: NavigationRoute.overview, position: 0);
    kpiBox.add(newFavorite);
    _loadKpiBlocByRoute(NavigationRoute.overview, context);
  }


  @override
  void removeFavorite(KeyPerformanceIndex kpi, BuildContext context) {
    final deleteKPI = getOverviewKPIs().firstWhere((k) =>
      k.name == kpi.name &&
      k.category == kpi.category &&
      k.route == NavigationRoute.overview,
      orElse: () => EmptyObjects.kpi,
    );

    if(deleteKPI != EmptyObjects.kpi) {
      final deleteKey = deleteKPI.key;
      kpiBox.delete(deleteKey);
      for(var k in getOverviewKPIs()) {
        if(k.position > deleteKPI.position) {
          k.position--;
          k.save();
        }
      }
      _loadKpiBlocByRoute(NavigationRoute.overview, context);
    }
  }

  @override
  bool isFavorite(KeyPerformanceIndex kpi) {
    return kpiBox.values.any((k) => k.name == kpi.name && k.category == kpi.category && k.route == NavigationRoute.overview);
  }

  // Remove stored but unmapped KPIs
  // and update positions
  @override
  void removeUnmappedKPIs() {
    final allMappedKPIs = KPIUtils.getAllDefaultKPIs();
    final allStoredKPIs = getAllKPIs();

    // Only continue if the database is not empty
    if(allStoredKPIs.isEmpty) return;

    // Check for unmapped but stored KPIs
    final allStoredKPIsAreMapped = allStoredKPIs.every((stored) =>
        allMappedKPIs.any((mapped) => mapped.name == stored.name && mapped.category == stored.category));

    debugPrint('all stored KPIs are mapped: $allStoredKPIsAreMapped');

    if(!allStoredKPIsAreMapped) {
      final removeKPIs = getUnmappedKPIs();

      for(final removeKpi in removeKPIs) {
        // Delete from db
        kpiBox.delete(removeKpi.key);

        // Update positions in route
        final kpisByRoute = getKPIsByRoute(removeKpi.route);
        for(final kpi in kpisByRoute){
          if (kpi.position > removeKpi.position) {
            kpi.position--;
            kpi.save();
          }
        }
      }
    }
  }


  // Get a list of all stored KPIs which are unmapped
  @override
  List<KeyPerformanceIndex> getUnmappedKPIs() {
    final allMappedKPIs = KPIUtils.getAllDefaultKPIs();
    final allStoredKPIs = getAllKPIs();

    return allStoredKPIs.where((stored) =>
    !allMappedKPIs.any((mapped) => mapped.name == stored.name && mapped.category == stored.category)).toList();
  }


}