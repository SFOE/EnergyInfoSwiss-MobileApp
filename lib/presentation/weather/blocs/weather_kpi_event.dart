part of 'weather_kpi_bloc.dart';

@immutable
abstract class WeatherKpiEvent extends Equatable {
  const WeatherKpiEvent();

  @override
  List<Object> get props => [];
}

class LoadWeatherKpi extends WeatherKpiEvent {}
class UpdateWeatherKpi extends WeatherKpiEvent {}