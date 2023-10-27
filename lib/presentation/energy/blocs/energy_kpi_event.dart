part of 'energy_kpi_bloc.dart';

@immutable
abstract class EnergyKpiEvent extends Equatable {
  const EnergyKpiEvent();

  @override
  List<Object> get props => [];
}

class LoadEnergyKpi extends EnergyKpiEvent {}
class UpdateEnergyKpi extends EnergyKpiEvent {}
