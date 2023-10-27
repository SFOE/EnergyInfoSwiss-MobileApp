import 'package:energy_dashboard/core/helpers/api_base_helper.dart';
import 'package:energy_dashboard/core/mixins/api_repository_mixin.dart';
import 'package:energy_dashboard/core/types/kpi_category.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/empty_objects.dart';
import 'package:energy_dashboard/core/utils/kpi_utils.dart';
import 'package:energy_dashboard/data/repositories/database_repository.dart';
import 'package:energy_dashboard/domain/abstractions/api_repository_abstraction.dart';
import 'package:energy_dashboard/domain/entities/ampel.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:get_it/get_it.dart';

/// Repository for API requests
///
/// Contains all necessary api requests
/// to receive the desired content from the API
class ApiRepository extends ApiRepositoryAbstraction with ApiRepositoryMixin{


  ///* AMPEL *///

  @override
  Future<List<Ampel>> getAmpel() async {
    final response = await GetIt.I.get<ApiBaseHelper>().get('ampel');
    return AmpelResponse.fromJson(response).results;
  }

  ///* TRANSLATIONS *///

  @override
  Future<Map<String, dynamic>> getApiTranslations() async {
    final response = await GetIt.I.get<ApiBaseHelper>().get('dynamic-translations');
    return response;
  }


  ///* KPIs *///

  @override
  Future<List<KeyPerformanceIndex>> getEnergyKPIs() async {
    final response = await GetIt.I.get<ApiBaseHelper>().get('dashboard/strom');
    final List<KeyPerformanceIndex> newKPIs = KeyPerformanceIndexResponse.fromJson(
      json: response,
      category: KPICategory.energy,
      route: NavigationRoute.energy,
    ).results;
    // Create or update KPIs in database
    await GetIt.I.get<DatabaseRepository>().storeKPIs(newKPIs);
    // Retrieve updated KPIs in correct order from database
    List<KeyPerformanceIndex> kpis = GetIt.I.get<DatabaseRepository>().getEnergyKPIs();
    return kpis;
  }

  @override
  Future<List<KeyPerformanceIndex>> getGasKPIs() async {
    final response = await GetIt.I.get<ApiBaseHelper>().get('dashboard/gas');
    final List<KeyPerformanceIndex> newKPIs = KeyPerformanceIndexResponse.fromJson(
      json: response,
      category: KPICategory.gas,
      route: NavigationRoute.gas
    ).results;
    // Create or update KPIs in database
    await GetIt.I.get<DatabaseRepository>().storeKPIs(newKPIs);
    // Retrieve updated KPIs in correct order from database
    List<KeyPerformanceIndex> kpis = GetIt.I.get<DatabaseRepository>().getGasKPIs();
    return kpis;
  }

  @override
  Future<List<KeyPerformanceIndex>> getPriceKPIs() async {
    final response = await GetIt.I.get<ApiBaseHelper>().get('dashboard/preise');
    final List<KeyPerformanceIndex> newKPIs = KeyPerformanceIndexResponse.fromJson(
      json: response,
      category: KPICategory.price,
      route: NavigationRoute.price
    ).results;
    // Create or update KPIs in database
    await GetIt.I.get<DatabaseRepository>().storeKPIs(newKPIs);
    // Retrieve updated KPIs in correct order from database
    List<KeyPerformanceIndex> kpis = GetIt.I.get<DatabaseRepository>().getPriceKPIs();
    return kpis;
  }

  @override
  Future<List<KeyPerformanceIndex>> getWeatherKPIs() async {
    final response = await GetIt.I.get<ApiBaseHelper>().get('v2/dashboard/wetter');
    final List<KeyPerformanceIndex> newKPIs = KeyPerformanceIndexResponse.fromJson(
      json: response,
      category: KPICategory.weather,
      route: NavigationRoute.weather
    ).results;
    // Create or update KPIs in database
    await GetIt.I.get<DatabaseRepository>().storeKPIs(newKPIs);
    // Retrieve updated KPIs in correct order from database
    List<KeyPerformanceIndex> kpis = GetIt.I.get<DatabaseRepository>().getWeatherKPIs();
    return kpis;
  }


  @override
  Future<List<KeyPerformanceIndex>> getOverviewKPIs() async {
    final databaseRepository = GetIt.I.get<DatabaseRepository>();
    final List<KeyPerformanceIndex> overviewDbKpis = databaseRepository.getOverviewKPIs();
    final Set<KPICategory> overviewCategories = overviewDbKpis.map((k) => k.category).toSet();

    // only in first use -> show default overview KPIs
    if(databaseRepository.kpiBox.values.isEmpty){
      overviewCategories.addAll({
        KPICategory.energy,
        KPICategory.gas,
        KPICategory.price,
        KPICategory.weather
      });
      overviewDbKpis.addAll(KPIUtils.defaultOverviewKPIs);
    }

    // store all KPIs from API for each category
    List<KeyPerformanceIndex> allApiKpis = await Future.wait(
      overviewCategories.map((c) => getKPIsByCategory(c)),
    ).then((listOfLists) => listOfLists.expand((kpis) => kpis).toList());

    // store all overview KPIs from Db with new values from API
    List<KeyPerformanceIndex> newKPIs = allApiKpis.map((k) {
      final dbKpi = overviewDbKpis.firstWhere(
        (aKpi) => aKpi.name == k.name && aKpi.category == k.category,
        orElse: () => EmptyObjects.kpi,
      );

      return dbKpi != EmptyObjects.kpi
        ? dbKpi.copyWith(
            value: k.value,
            trend: k.trend,
            trendRating: k.trendRating,
            date: k.date,
        ) : null;
    }).whereType<KeyPerformanceIndex>().toList();

    // Create or update KPIs in database
    await GetIt.I.get<DatabaseRepository>().storeKPIs(newKPIs);

    // Retrieve updated KPIs in correct order from database
    List<KeyPerformanceIndex> kpis = GetIt.I.get<DatabaseRepository>().getOverviewKPIs();

    return kpis;
  }

  @override
  Future<List<KeyPerformanceIndex>> getKPIsByCategory(KPICategory category) async {
    late String endpoint;

    switch (category) {
      case KPICategory.energy:
        endpoint = 'dashboard/strom';
        break;
      case KPICategory.gas:
        endpoint = 'dashboard/gas';
        break;
      case KPICategory.price:
        endpoint = 'dashboard/preise';
        break;
      case KPICategory.weather:
        endpoint = 'v2/dashboard/wetter';
        break;
    }

    final response = await GetIt.I.get<ApiBaseHelper>().get(endpoint);

    return KeyPerformanceIndexResponse.fromJson(
      json: response,
      category: category,
      route: category.toRoute,
    ).results;
  }

}

