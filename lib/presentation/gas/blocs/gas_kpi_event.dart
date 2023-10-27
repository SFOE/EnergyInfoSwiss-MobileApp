part of 'gas_kpi_bloc.dart';

@immutable
abstract class GasKpiEvent extends Equatable {
  const GasKpiEvent();

  @override
  List<Object> get props => [];
}

class LoadGasKpi extends GasKpiEvent {}
class UpdateGasKpi extends GasKpiEvent {}
