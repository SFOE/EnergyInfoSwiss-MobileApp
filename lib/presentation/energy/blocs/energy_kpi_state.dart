part of 'energy_kpi_bloc.dart';

@immutable
abstract class EnergyKpiState extends Equatable {
  const EnergyKpiState();

  @override
  List<Object> get props => [];
}

class EnergyKpiInitial extends EnergyKpiState {
  @override
  List<Object> get props => [];
}

class EnergyKpiLoading extends EnergyKpiState {}

class EnergyKpiError extends EnergyKpiState{
  final Exception ex;

  const EnergyKpiError(this.ex);

  @override
  List<Object> get props => [ex];
}

class EnergyKpiData extends EnergyKpiState{
  final List<KeyPerformanceIndex> result;

  const EnergyKpiData(this.result);

  @override
  List<Object> get props => [result];
}
