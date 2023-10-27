part of 'overview_kpi_bloc.dart';

@immutable
abstract class OverviewKpiState extends Equatable {
  const OverviewKpiState();

  @override
  List<Object> get props => [];
}

class OverviewKpiInitial extends OverviewKpiState {
  @override
  List<Object> get props => [];
}

class OverviewKpiLoading extends OverviewKpiState {}

class OverviewKpiError extends OverviewKpiState{
  final Exception ex;

  const OverviewKpiError(this.ex);

  @override
  List<Object> get props => [ex];
}

class OverviewKpiData extends OverviewKpiState{
  final List<KeyPerformanceIndex> result;

  const OverviewKpiData(this.result);

  @override
  List<Object> get props => [result];
}
