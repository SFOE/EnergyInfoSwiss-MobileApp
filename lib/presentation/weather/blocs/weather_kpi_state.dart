part of 'weather_kpi_bloc.dart';

@immutable
abstract class WeatherKpiState extends Equatable {
  const WeatherKpiState();

  @override
  List<Object> get props => [];
}

class WeatherKpiInitial extends WeatherKpiState {
  @override
  List<Object> get props => [];
}

class WeatherKpiLoading extends WeatherKpiState {}

class WeatherKpiError extends WeatherKpiState{
  final Exception ex;

  const WeatherKpiError(this.ex);

  @override
  List<Object> get props => [ex];
}

class WeatherKpiData extends WeatherKpiState{
  final List<KeyPerformanceIndex> result;

  const WeatherKpiData(this.result);

  @override
  List<Object> get props => [result];
}
