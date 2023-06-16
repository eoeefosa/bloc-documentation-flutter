part of 'acontainerbloc.dart';

sealed class ContainerState {
  final int value;

  ContainerState(this.value);
}

final class NoOptionSelected extends ContainerState {
  NoOptionSelected() : super(1);
}

final class CorrectOptionSelected extends ContainerState {
  CorrectOptionSelected() : super(2);
}

final class WrongOptionSelected extends ContainerState {
  WrongOptionSelected() : super(3);
}

final class Startquiz extends ContainerState {
  Startquiz() : super(4);
}
