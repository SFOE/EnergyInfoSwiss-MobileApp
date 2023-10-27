part of 'ampel_bloc.dart';

abstract class AmpelEvent extends Equatable {
  const AmpelEvent();

  @override
  List<Object> get props => [];
}

class LoadAmpel extends AmpelEvent {}

