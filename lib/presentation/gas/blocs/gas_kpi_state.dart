part of 'gas_kpi_bloc.dart';

@immutable
abstract class GasKpiState extends Equatable {
  const GasKpiState();

  @override
  List<Object> get props => [];
}

class GasKpiInitial extends GasKpiState {
  @override
  List<Object> get props => [];
}

class GasKpiLoading extends GasKpiState {}

class GasKpiError extends GasKpiState{
  final Exception ex;

  const GasKpiError(this.ex);

  @override
  List<Object> get props => [ex];
}

class GasKpiData extends GasKpiState{
  final List<KeyPerformanceIndex> result;

  const GasKpiData(this.result);

  @override
  List<Object> get props => [result];
}
