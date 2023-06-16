part of "option_bloc.dart";

sealed class OptionEvent {
  const OptionEvent();
}

final class SelecteOption extends OptionEvent {
  final int index;

  SelecteOption({required this.index});
}
