import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'acontainerevent.dart';

part 'acontainerstate.dart';

class ContainerBloc extends Bloc<ContainerEvent, int?> {
  int correctoption = 1;

  ContainerBloc() : super(null) {
    on<Optionclicked>((event, emit) => emit(event.selectedoption),);
  }

}


sealed class ContainerEvent {}

final class Optionclicked extends ContainerEvent {
  final int? selectedoption;
  Optionclicked({required this.selectedoption});
}
