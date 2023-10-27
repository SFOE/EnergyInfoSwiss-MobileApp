part of 'price_kpi_bloc.dart';

@immutable
abstract class PriceKpiState extends Equatable {
  const PriceKpiState();

  @override
  List<Object> get props => [];
}

class PriceKpiInitial extends PriceKpiState {
  @override
  List<Object> get props => [];
}

class PriceKpiLoading extends PriceKpiState {}

class PriceKpiError extends PriceKpiState{
  final Exception ex;

  const PriceKpiError(this.ex);

  @override
  List<Object> get props => [ex];
}

class PriceKpiData extends PriceKpiState{
  final List<KeyPerformanceIndex> result;

  const PriceKpiData(this.result);

  @override
  List<Object> get props => [result];
}
