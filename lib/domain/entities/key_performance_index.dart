import 'package:energy_dashboard/core/types/kpi_category.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/types/trend.dart';
import 'package:energy_dashboard/core/types/trend_rating.dart';
import 'package:energy_dashboard/core/utils/kpi_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'key_performance_index.g.dart';

@HiveType(typeId: 0)
class KeyPerformanceIndex extends HiveObject{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String? value;
  @HiveField(2)
  late Trend? trend;
  @HiveField(3)
  late TrendRating? trendRating;
  @HiveField(4)
  late String? date;
  @HiveField(5)
  late KPICategory category;
  @HiveField(6)
  late bool isExpanded;
  @HiveField(7)
  late NavigationRoute route;
  @HiveField(8)
  late bool isDisabled;
  @HiveField(9)
  late int position;

  KeyPerformanceIndex({
    required this.name,
    required this.value,
    this.trend,
    this.trendRating,
    this.date,
    required this.category,
    this.isExpanded = false,
    required this.route,
    this.isDisabled = false,
    required this.position
  });

  factory KeyPerformanceIndex.fromJson({
    required Map<String, dynamic> json,
    required String name,
    required KPICategory category,
    required int position,
    required NavigationRoute route,
  }) => KeyPerformanceIndex(
    name: name,
    value: json['value']?.toString(),
    trend: KPIUtils.getTrend(json['trend'].toString()),
    trendRating: KPIUtils.getTrendRating(json['trendRating'].toString()),
    date: json['date'].toString(),
    category: category,
    isExpanded: false,
    route: route,
    isDisabled: false,
    position: position
  );

  KeyPerformanceIndex copyWith({
    String? name,
    String? value,
    Trend? trend,
    TrendRating? trendRating,
    String? date,
    KPICategory? category,
    bool? isExpanded,
    NavigationRoute? route,
    bool? isDisabled,
    int? position
  }){
    return KeyPerformanceIndex(
      name: name ?? this.name,
      value: value ?? this.value,
      trend: trend ?? this.trend,
      trendRating: trendRating ?? this.trendRating,
      date: date ?? this.date,
      category: category ?? this.category,
      isExpanded: isExpanded ?? this.isExpanded,
      route: route ?? this.route,
      isDisabled: isDisabled ?? this.isDisabled,
      position: position ?? this.position
    );
  }

  @override
  String toString(){
    return '[$route] $name: $value, $category, $position';
  }


}

class KeyPerformanceIndexResponse{
  late List<KeyPerformanceIndex> results;
  late KeyPerformanceIndex? result;

  KeyPerformanceIndexResponse.fromJson({required Map<String, dynamic> json, required NavigationRoute route, required KPICategory category, int? position}){
    assert(!(route == NavigationRoute.overview && position == null), 'Position must be provided for overview route');

    results = [];
    result = null;
    List<KeyPerformanceIndex> defaultKPIs = KPIUtils.getDefaultKPIsByRoute(route);
    int index = 0;

    for(var k in json.entries){
      // avoid adding empty (null) KPIs
      if(k.value == null){
        continue;
      }
      // avoid adding not yet defined KPIs
      if(!defaultKPIs.any((defaultKpi) => defaultKpi.name == k.key)){
        continue;
      }

      results.add(KeyPerformanceIndex.fromJson(json: k.value, name: k.key, route: route, category: category, position: index));
      index++;
    }

  }

}