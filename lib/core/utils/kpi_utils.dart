import 'package:energy_dashboard/core/helpers/web_base_helper.dart';
import 'package:energy_dashboard/core/types/kpi_category.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/types/trend.dart';
import 'package:energy_dashboard/core/types/trend_rating.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

///
/// Utility methods that are used for the KPIs
///
class KPIUtils{

  /// * DEFAULT KPIS * ///

  static final List<KeyPerformanceIndex> defaultOverviewKPIs = [
    KeyPerformanceIndex(name: 'aktuellerVerbrauch', value: '161', route: NavigationRoute.overview, category: KPICategory.energy, position: 0),
    KeyPerformanceIndex(name: 'nettoImport', value: '32', route: NavigationRoute.overview, category: KPICategory.gas, position: 1),
    KeyPerformanceIndex(name: 'stromBoerse', value: '81', route: NavigationRoute.overview, category: KPICategory.price, position: 2),
    KeyPerformanceIndex(name: 'endenergieverbrauch', value: null, route: NavigationRoute.overview, category: KPICategory.energy, position: 3),
    KeyPerformanceIndex(name: 'produktionPhotovoltaik', value: '0', route: NavigationRoute.overview, category: KPICategory.energy, position: 4),
    KeyPerformanceIndex(name: 'produktionWinterproduktion', value: '0', route: NavigationRoute.overview, category: KPICategory.energy, position: 5),
    KeyPerformanceIndex(name: 'aktuelleTemperatur', value: '20.2', route: NavigationRoute.overview, category: KPICategory.weather, position: 6),
  ];

  static final List<KeyPerformanceIndex> defaultEnergyKPIs = [
    KeyPerformanceIndex(name: 'aktuellerVerbrauch', value: '161', route: NavigationRoute.energy, category: KPICategory.energy, position: 0),
    KeyPerformanceIndex(name: 'gesamtProduktion', value: '230', route: NavigationRoute.energy, category: KPICategory.energy, position: 1),
    KeyPerformanceIndex(name: 'produktionKkwCH', value: '70', route: NavigationRoute.energy, category: KPICategory.energy, position: 2),
    KeyPerformanceIndex(name: 'produktionKkwFR', value: '890', route: NavigationRoute.energy, category: KPICategory.energy, position: 3),
    KeyPerformanceIndex(name: 'speicherfuellstand', value: '84.6', route: NavigationRoute.energy, category: KPICategory.energy, position: 4),
    //KeyPerformanceIndex(name: 'nettoImport', value: '22', route: NavigationRoute.energy, category: KPICategory.energy, position: 5),  // replace by nettoImportExport
    //KeyPerformanceIndex(name: 'nettoExport', value: '73', route: NavigationRoute.energy, category: KPICategory.energy, position: 6),  // replaced by nettoImportExport
    KeyPerformanceIndex(name: 'nettoImportExport', value: '-15', route: NavigationRoute.energy, category: KPICategory.energy, position: 5),
    KeyPerformanceIndex(name: 'aktuelleGesamteinsparung', value: '0', route: NavigationRoute.energy, category: KPICategory.energy, position: 6),
    KeyPerformanceIndex(name: 'endenergieverbrauch', value: null, route: NavigationRoute.energy, category: KPICategory.energy, position: 7),
    KeyPerformanceIndex(name: 'produktionPhotovoltaik', value: '0', route: NavigationRoute.energy, category: KPICategory.energy, position: 8),
    KeyPerformanceIndex(name: 'produktionWinterproduktion', value: '0', route: NavigationRoute.energy, category: KPICategory.energy, position: 9),
  ];
  
  static final List<KeyPerformanceIndex> defaultGasKPIs = [
    //KeyPerformanceIndex(name: 'aktuellerVerbrauch', value: '789', route: NavigationRoute.gas, category: KPICategory.gas, position: 0),  // replaced by nettoImport
    KeyPerformanceIndex(name: 'fuellstandNachbarlaender', value: '94.4', route: NavigationRoute.gas, category: KPICategory.gas, position: 0),
    KeyPerformanceIndex(name: 'nettoImport', value: '32', route: NavigationRoute.gas, category: KPICategory.gas, position: 1),
    KeyPerformanceIndex(name: 'aktuelleGesamteinsparung', value: '145.6', route: NavigationRoute.gas, category: KPICategory.gas, position: 2),
    KeyPerformanceIndex(name: 'importEuropa', value: '84.8', route: NavigationRoute.gas, category: KPICategory.gas, position: 3),
  ];


  static final List<KeyPerformanceIndex> defaultPriceKPIs = [
    KeyPerformanceIndex(name: 'stromBoerse', value: '81', route: NavigationRoute.price, category: KPICategory.price, position: 0),
    KeyPerformanceIndex(name: 'strompreisKarteEuropa', value: '94.7', route: NavigationRoute.price, category: KPICategory.price, position: 1),
    KeyPerformanceIndex(name: 'gasBoerse', value: '35.6', route: NavigationRoute.price, category: KPICategory.price, position: 2),
    KeyPerformanceIndex(name: 'heizoelEntwicklung', value: '168', route: NavigationRoute.price, category: KPICategory.price, position: 3),
    KeyPerformanceIndex(name: 'treibstoffBenzin', value: '134', route: NavigationRoute.price, category: KPICategory.price, position: 4),
    KeyPerformanceIndex(name: 'treibstoffDiesel', value: '132', route: NavigationRoute.price, category: KPICategory.price, position: 5),
    KeyPerformanceIndex(name: 'brennholzEndverbrauch', value: '134', route: NavigationRoute.price, category: KPICategory.price, position: 6),
    KeyPerformanceIndex(name: 'fernwaermeEndverbrauch', value: '136', route: NavigationRoute.price, category: KPICategory.price, position: 7),
  ];

  static final List<KeyPerformanceIndex> defaultWeatherKPIs = [
    KeyPerformanceIndex(name: 'aktuelleTemperatur', value: '20.2', route: NavigationRoute.weather, category: KPICategory.weather, position: 0),
    //KeyPerformanceIndex(name: 'prognoseTemperatur', value: '16', route: NavigationRoute.weather, category: KPICategory.weather, position: 1), // replaced by aktuelleTemperatur
    KeyPerformanceIndex(name: 'schneereserven', value: '31', route: NavigationRoute.weather, category: KPICategory.weather, position: 1),
    KeyPerformanceIndex(name: 'niederschlaege', value: '21.4', route: NavigationRoute.weather, category: KPICategory.weather, position: 2),
    KeyPerformanceIndex(name: 'heizgradtage', value: '100', route: NavigationRoute.weather, category: KPICategory.weather, position: 3),
  ];


  /// Utility methods

  static List<KeyPerformanceIndex> getAllDefaultKPIs(){
    return [...defaultOverviewKPIs+defaultEnergyKPIs+defaultGasKPIs+defaultPriceKPIs+defaultWeatherKPIs];
  }

  static List<KeyPerformanceIndex> getDefaultKPIsByRoute(NavigationRoute route){
    switch(route){
      case NavigationRoute.overview:
        return defaultOverviewKPIs;
      case NavigationRoute.energy:
        return defaultEnergyKPIs;
      case NavigationRoute.gas:
        return defaultGasKPIs;
      case NavigationRoute.price:
        return defaultPriceKPIs;
      case NavigationRoute.weather:
        return defaultWeatherKPIs;
    }
  }

  // returns the TrendRating based on the json title
  static TrendRating? getTrendRating(String s){
    switch(s){
      case 'negativ':
        return TrendRating.negative;
      case 'neutral':
        return TrendRating.neutral;
      case 'positiv':
        return TrendRating.positive;
      default:
        return null;
    }
  }

  // returns the Trend based on the json title
  static Trend? getTrend(String s){
    switch(s){
      case 'up_strong':
        return Trend.upStrong;
      case 'up_mild':
        return Trend.upMild;
      case 'neutral':
        return Trend.neutral;
      case 'down_mild':
        return Trend.downMild;
      case 'down_strong':
        return Trend.downStrong;
      default:
        debugPrint('[TrendExtension] getTrendByString: Invalid String $s');
        return null;
    }
  }

  // returns the translated KPI category title
  static String getCategoryTitle(KPICategory category, BuildContext context){
    switch(category){
      case KPICategory.energy:
        return Translations.of(context)!.text('dashboard.strom.context-name');
      case KPICategory.gas:
        return Translations.of(context)!.text('dashboard.gas.context-name');
      case KPICategory.price:
        return Translations.of(context)!.text('dashboard.preise.context-name.lang');
      case KPICategory.weather:
        return Translations.of(context)!.text('dashboard.wetter.context-name');
    }
  }

  // returns the KPICategory based on its title
  static KPICategory getCategoryByTitle(String title){
    switch(title.toLowerCase()){
      case 'energy':
        return KPICategory.energy;
      case 'gas':
        return KPICategory.gas;
      case 'price':
        return KPICategory.price;
      case 'weather':
        return KPICategory.weather;
      default:
        throw Exception('[KPIUtils] getCategoryByTitle: Invalid title $title');
    }
  }

  // returns a deep copy of a given list
  List<KeyPerformanceIndex> deepCopyListOfKPIs(List<KeyPerformanceIndex> sourceList) {
    final copiedList = <KeyPerformanceIndex>[];
    for (final kpi in sourceList) {
      final KeyPerformanceIndex k = KeyPerformanceIndex(
        name: kpi.name,
        value: kpi.value,
        trend: kpi.trend,
        trendRating: kpi.trendRating,
        date: kpi.date,
        category: kpi.category,
        isExpanded: kpi.isExpanded,
        route: kpi.route,
        isDisabled: kpi.isDisabled,
        position: kpi.position
      );
      copiedList.add(k);
    }
    return copiedList;
  }


  /// Key Name Mappings

  // returns the translated KPI title based on its json key name
  String getTitleByJsonKey(String key, KPICategory category, BuildContext context){
    switch(key){
      // Strom
      case 'aktuellerVerbrauch':
          if(category == KPICategory.energy) {
            return Translations.of(context)!.text('uebersicht_strom_verbrauch.titel');
          } else if(category == KPICategory.gas){
            return Translations.of(context)!.text('uebersicht_gas_verbrauch.titel'); //unused
          } else {
            return '';
          }
      case 'gesamtProduktion':
        return Translations.of(context)!.text('uebersicht_strom_produktion.titel');
      case 'speicherfuellstand':
        return Translations.of(context)!.text('uebersicht_strom_speicherfüllstand-seen.titel');
      case 'nettoImport':
        if(category == KPICategory.energy){
          return Translations.of(context)!.text('uebersicht_strom_import.titel');
        }else if(category == KPICategory.gas){
          return Translations.of(context)!.text('uebersicht_gas_import.titel'); // unused
        }else{
          return '';
        }
      case 'nettoExport':
        return Translations.of(context)!.text('uebersicht_strom_export.titel'); // unused
      case 'nettoImportExport':
        return Translations.of(context)!.text('kpi-strom-9_import-export.titel');
      case 'aktuelleGesamteinsparung':
        if(category == KPICategory.energy){
          return Translations.of(context)!.text('uebersicht_strom_mehr-minderverbrauch.titel');
        }else if(category == KPICategory.gas){
          return Translations.of(context)!.text('uebersicht_gas_mehr-minderverbrauch.titel');
        }else{
          return '';
        }
      case 'produktionKkwCH':
        return Translations.of(context)!.text('kpi-strom-6_kkw-ch.titel');
      case 'produktionKkwFR':
        return Translations.of(context)!.text('kpi-strom-6_kkw-fr.titel');
      case 'endenergieverbrauch':
        return Translations.of(context)!.text('kpi-strom-2_energieverbrauch.titel');
      case 'produktionPhotovoltaik':
        return Translations.of(context)!.text('kpi-strom-5_produktion-pv.titel');
      case 'produktionWinterproduktion':
        return Translations.of(context)!.text('kpi-strom-5_winterproduktion.titel');

      // Gas
      case 'fuellstandNachbarlaender':
        return Translations.of(context)!.text('uebersicht_gas_fuellstand-nachbarlaender.titel');
      case 'importEuropa':
        return Translations.of(context)!.text('kpi-gas-5_import-europa.titel');
      // Preise
      case 'stromBoerse':
        return Translations.of(context)!.text('dashboard.strom.context-name');
      case 'strompreisKarteEuropa':
        return Translations.of(context)!.text('kpi-preise-8_strom_europa.titel');
      case 'gasBoerse':
        return Translations.of(context)!.text('dashboard.gas.context-name');
      case 'heizoelEntwicklung':
        return Translations.of(context)!.text('dashboard.oel.context-name');
      case 'treibstoffBenzin':
        return Translations.of(context)!.text('dashboard.benzin.context-name');
      case 'treibstoffDiesel':
        return Translations.of(context)!.text('dashboard.diesel.context-name');
      case 'brennholzEndverbrauch':
        return Translations.of(context)!.text('dashboard.holz.context-name');
      case 'fernwaermeEndverbrauch':
        return Translations.of(context)!.text('dashboard.fernwaerme.context-name');
      // Wetter
      case 'aktuelleTemperatur':
        return Translations.of(context)!.text('uebersicht_wetter_aktuell.titel');
      case 'prognoseTemperatur':
        return Translations.of(context)!.text('uebersicht_wetter_prognose.titel');  // unused
      case 'schneereserven':
        return Translations.of(context)!.text('uebersicht_wetter_schneereserven.titel');
      case 'niederschlaege':
        return Translations.of(context)!.text('uebersicht_wetter_niederschlaege.titel');
      case 'heizgradtage':
        return Translations.of(context)!.text('uebersicht_wetter_heizgradtage.titel');
      default:
        debugPrint('[KPIUtils] getTitleByJsonKey: Invalid key $key');
        return '';
    }
  }

  // returns the details web page url by its json key name
  String getDetailsUrlByJsonKey(String key, KPICategory category, BuildContext context){
    switch(key){
      // Strom
      case 'aktuellerVerbrauch':
        if(category == KPICategory.energy) {
          return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/stromverbrauch');
        } else if(category == KPICategory.gas){
          return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/gas/import'); // unused
        } else {
          return '';
        }
      case 'gesamtProduktion':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/produktion');
      case 'speicherfuellstand':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/fuellstaende-speicherseen');
      case 'nettoImport':
        if(category == KPICategory.energy) {
          return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/import-export');
        } else if(category == KPICategory.gas){
          return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/gas/import'); // unussed
        } else {
          return '';
        }
      case 'nettoExport':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/import-export'); // unused
      case 'nettoImportExport':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/import-export');
      case 'aktuelleGesamteinsparung':
        if(category == KPICategory.energy) {
          return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/minder-mehrverbrauch');
        } else if(category == KPICategory.gas){
          return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/gas/sparziel');
        } else {
          return '';
        }
      case 'produktionKkwCH':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/kkw-ch');
      case 'produktionKkwFR':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/kkw-fr');
      case 'endenergieverbrauch':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/energieverbrauch');
      case 'produktionPhotovoltaik':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/produktion-pv');
      case 'produktionWinterproduktion':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/strom/winterproduktion');
      // Gas
      case 'fuellstandNachbarlaender':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/gas/eu-gasspeicher');
      case 'importEuropa':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/gas/import-europa');
      // Preise
      case 'stromBoerse':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/preise/strom');
      case 'strompreisKarteEuropa':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/preise/strom-karte');
      case 'gasBoerse':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/preise/gas');
      case 'heizoelEntwicklung':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/preise/oel');
      case 'treibstoffBenzin':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/preise/treibstoff');
      case 'treibstoffDiesel':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/preise/treibstoff');
      case 'brennholzEndverbrauch':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/preise/brennholz');
      case 'fernwaermeEndverbrauch':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/preise/fernwaerme');
      // Wetter
      case 'aktuelleTemperatur':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/wetter/aktuell');
      case 'prognoseTemperatur':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/wetter/aktuell'); // unused
      case 'schneereserven':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/wetter/schneereserven');
      case 'niederschlaege':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/wetter/niederschlag');
      case 'heizgradtage':
        return GetIt.I.get<WebBaseHelper>().getWebUrl(context: context, path: '/wetter/heizgradtage');
      default:
        debugPrint('[KPIUtils] getDetailsUrlByJsonKey: Invalid key $key');
        return '';
    }
  }

  // returns the value unit (GWh,%,...) based on its json key name
  String getValueUnitByJsonKey(String key){
    switch(key){
      case 'aktuellerVerbrauch':   //unused (for gas only)
      case 'gesamtProduktion':
      case 'nettoImport': // unused (for energy)
      case 'nettoExport': // unused (for energy)
      case 'nettoImportExport':
      case 'produktionKkwCH':
      case 'produktionKkwFR':
      case 'produktionPhotovoltaik':
      case 'produktionWinterproduktion':
        return 'GWh';
      case 'speicherfuellstand':
      case 'aktuelleGesamteinsparung':
      case 'fuellstandNachbarlaender':
      case 'heizoelEntwicklung':
      case 'treibstoffBenzin':
      case 'treibstoffDiesel':
      case 'brennholzEndverbrauch':
      case 'fernwaermeEndverbrauch':
      case 'niederschlaege':
        return '%';
      case 'stromBoerse':
      case 'gasBoerse':
      case 'strompreisKarteEuropa':
        return 'EUR/MWh';
      // Gas
      case 'importEuropa':
        return 'Mio m\u00B3';
      // Wetter
      case 'aktuelleTemperatur':
      case 'prognoseTemperatur':  // unused
        return '°C';
      case 'schneereserven':
        return 'mm';
      case 'heizgradtage':
        return 'HGT';
      default:
        debugPrint('[KPIUtils] getValueUnitByJsonKey: Invalid key $key');
        return '';
    }
  }



  // returns the chart icon asset path based on its json key name
  String getChartAssetPathByJsonKey(String key){
    switch(key){
    // Strom
      case 'aktuellerVerbrauch':   //unused (for gas only)
        return 'assets/icons/charts/line-chart.svg';
      case 'speicherfuellstand':
      case 'nettoImport': // unused (for energy)
      case 'nettoExport': // unused (for energy)
        return 'assets/icons/charts/line-chart.svg';
      case 'nettoImportExport':
      case 'endenergieverbrauch':
        return 'assets/icons/charts/area-chart.svg';
      case 'produktionKkwCH':
      case 'produktionKkwFR':
        return 'assets/icons/charts/line-chart.svg';
      case 'gesamtProduktion':
      case 'importEuropa':
        return 'assets/icons/charts/donut-chart.svg';
      case 'aktuelleGesamteinsparung':
        return 'assets/icons/charts/plot-chart.svg';
      case 'produktionPhotovoltaik':
      case 'produktionWinterproduktion':
        return 'assets/icons/charts/bar-chart.svg';
      // Gas
      case 'fuellstandNachbarlaender':
        return 'assets/icons/charts/semi-donut-chart.svg';
      // Preise
      case 'stromBoerse':
      case 'gasBoerse':
      case 'heizoelEntwicklung':
      case 'treibstoffBenzin':
      case 'treibstoffDiesel':
      case 'brennholzEndverbrauch':
      case 'fernwaermeEndverbrauch':
        return 'assets/icons/charts/line-chart.svg';
      case 'strompreisKarteEuropa':
        return 'assets/icons/charts/grid-chart.svg';
      // Wetter
      case 'aktuelleTemperatur':
      case 'prognoseTemperatur':  // unused
      case 'schneereserven':
      case 'heizgradtage':
        return 'assets/icons/charts/line-chart.svg';
      case 'niederschlaege':
        return 'assets/icons/charts/bar-chart.svg';
      default:
        debugPrint('[KPIUtils] getDetailsUrlByJsonKey: Invalid key $key');
        return 'assets/icons/charts/line-chart.svg';
    }
  }
}