import 'package:energy_dashboard/data/repositories/api_repository.dart';
import 'package:energy_dashboard/data/repositories/database_repository.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'energy_kpi_event.dart';
part 'energy_kpi_state.dart';

class EnergyKpiBloc extends Bloc<EnergyKpiEvent, EnergyKpiState> {
  EnergyKpiBloc() : super(EnergyKpiInitial()) {
    on<LoadEnergyKpi>((event, emit) async {
      emit(EnergyKpiLoading());
      try{
        final List<KeyPerformanceIndex> result = await GetIt.I.get<ApiRepository>().getEnergyKPIs();
        emit(EnergyKpiData(result));
      } on Exception catch(e){
        emit(EnergyKpiError(e));
      }
    });
    on<UpdateEnergyKpi>((event, emit) async {
      try{
        final List<KeyPerformanceIndex> result = GetIt.I.get<DatabaseRepository>().getEnergyKPIs();
        emit(EnergyKpiData(result));
      } on Exception catch(e){
        emit(EnergyKpiError(e));
      }
    });
  }
}
