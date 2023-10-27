part of 'price_kpi_bloc.dart';

@immutable
abstract class PriceKpiEvent extends Equatable {
  const PriceKpiEvent();

  @override
  List<Object> get props => [];
}

class LoadPriceKpi extends PriceKpiEvent {}
class UpdatePriceKpi extends PriceKpiEvent {}