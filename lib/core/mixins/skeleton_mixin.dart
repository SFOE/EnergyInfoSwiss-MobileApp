import 'package:energy_dashboard/core/utils/empty_objects.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';


mixin SkeletonMixin{

  List<KeyPerformanceIndex> emptyKPIs(int number) => List.generate(number, (index) => EmptyObjects.kpi);

}