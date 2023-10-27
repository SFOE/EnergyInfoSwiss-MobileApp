part of 'overview_kpi_bloc.dart';

@immutable
abstract class OverviewKpiEvent extends Equatable {
  const OverviewKpiEvent();

  @override
  List<Object> get props => [];
}

class LoadOverviewKpi extends OverviewKpiEvent {}
class UpdateOverviewKpi extends OverviewKpiEvent {}
