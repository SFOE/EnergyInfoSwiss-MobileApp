part of 'ampel_bloc.dart';

abstract class AmpelState extends Equatable {
  const AmpelState();

  @override
  List<Object> get props => [];
}

class AmpelInitial extends AmpelState {
  @override
  List<Object> get props => [];
}

class AmpelLoading extends AmpelState {}

class AmpelError extends AmpelState{
  final Exception ex;

  const AmpelError(this.ex);

  @override
  List<Object> get props => [ex];
}

class AmpelData extends AmpelState{
  final List<Ampel> result;

  const AmpelData(this.result);

  @override
  List<Object> get props => [result];
}
