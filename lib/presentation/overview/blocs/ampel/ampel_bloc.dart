
import 'package:energy_dashboard/data/repositories/api_repository.dart';
import 'package:energy_dashboard/domain/entities/ampel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'ampel_event.dart';
part 'ampel_state.dart';

class AmpelBloc extends Bloc<AmpelEvent, AmpelState> {
  AmpelBloc() : super(AmpelInitial()) {
    on<LoadAmpel>((event, emit) async {
      emit(AmpelLoading());
      try{
        final List<Ampel> result = await GetIt.I.get<ApiRepository>().getAmpel();
        emit(AmpelData(result));
      } on Exception catch(e){
        emit(AmpelError(e));
      }
    });
  }
}
