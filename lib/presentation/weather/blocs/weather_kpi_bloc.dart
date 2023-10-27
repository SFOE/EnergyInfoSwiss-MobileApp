import 'package:energy_dashboard/data/repositories/api_repository.dart';
import 'package:energy_dashboard/data/repositories/database_repository.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'weather_kpi_event.dart';
part 'weather_kpi_state.dart';

class WeatherKpiBloc extends Bloc<WeatherKpiEvent, WeatherKpiState> {
  WeatherKpiBloc() : super(WeatherKpiInitial()) {
    on<LoadWeatherKpi>((event, emit) async {
      emit(WeatherKpiLoading());
      try{
        final List<KeyPerformanceIndex> result = await GetIt.I.get<ApiRepository>().getWeatherKPIs();
        emit(WeatherKpiData(result));
      } on Exception catch(e){
        emit(WeatherKpiError(e));
      }
    });
    on<UpdateWeatherKpi>((event, emit) async {
      try{
        final List<KeyPerformanceIndex> result = GetIt.I.get<DatabaseRepository>().getWeatherKPIs();
        emit(WeatherKpiData(result));
      } on Exception catch(e){
        emit(WeatherKpiError(e));
      }
    });
  }
}
