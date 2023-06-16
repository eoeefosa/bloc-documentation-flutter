part of 'option_bloc.dart';

sealed class OptionColorState {
  const OptionColorState();
}

final class NoOptionselected extends OptionColorState {
  const NoOptionselected();
}

final class OptionSelected extends OptionColorState {
  final int index;
  const OptionSelected(this.index);
}

final class UnselelectedOption extends OptionColorState{
  final int index;
  const UnselelectedOption(this.index);
}