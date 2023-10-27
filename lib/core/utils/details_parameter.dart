
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';

/// This class provides all properties for a details page
///
/// It is passed as the extra argument in go_router when navigating
/// to a details page
class DetailsParameter{
  final KeyPerformanceIndex kpi;
  final String title;
  final String url;
  const DetailsParameter({required this.kpi, required this.title, required this.url});
}