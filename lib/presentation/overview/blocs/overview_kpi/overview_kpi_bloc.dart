import 'package:energy_dashboard/data/repositories/api_repository.dart';
import 'package:energy_dashboard/data/repositories/database_repository.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'overview_kpi_event.dart';
part 'overview_kpi_state.dart';

class OverviewKpiBloc extends Bloc<OverviewKpiEvent, OverviewKpiState> {
  OverviewKpiBloc() : super(OverviewKpiInitial()) {
    on<LoadOverviewKpi>((event, emit) async {
      emit(OverviewKpiLoading());
      try{
        final List<KeyPerformanceIndex> result = await GetIt.I.get<ApiRepository>().getOverviewKPIs();
        emit(OverviewKpiData(result));
      } on Exception catch(e){
        emit(OverviewKpiError(e));
      }
    });
    on<UpdateOverviewKpi>((event, emit) async {
      try{
        final List<KeyPerformanceIndex> result = GetIt.I.get<DatabaseRepository>().getOverviewKPIs();
        emit(OverviewKpiData(result));
      } on Exception catch(e){
        emit(OverviewKpiError(e));
      }
    });
  }
}
