import 'package:bloc/bloc.dart';
part 'option_state.dart';
part 'option_event.dart';

class OptionBloc extends Bloc<OptionEvent, OptionColorState> {
  OptionBloc() : super(const NoOptionselected()) {
    on<SelecteOption>((event, emit) {
      _handleSelectOptionEvent(event, emit);
    });
  }
}

void _handleSelectOptionEvent(
    SelecteOption event, Emitter<OptionColorState> emit) {
  for (int i = 0; i < 4; i++) {
    if (i == event.index) {
      emit(OptionSelected(i));
    } else {
      emit(UnselelectedOption(i));
    }
  }
}
