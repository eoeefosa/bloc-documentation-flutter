part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  final int duration;
  const TimerState(this.duration);

  @override
  // TODO: implement props
  List<Object?> get props => [duration];
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.duration);
}

final class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);
}

final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);
}

final class TimerRunComplete extends TimerState {
  const   TimerRunComplete() : super(0);
}
