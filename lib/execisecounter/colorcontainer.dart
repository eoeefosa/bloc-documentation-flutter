import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ContainerColorevent {}

final class Wronganswer extends ContainerColorevent {}

final class Correctanswer extends ContainerColorevent {}

class ContainerColorBloc extends Bloc<ContainerColorevent, Color> {
  ContainerColorBloc() : super(Colors.blue) {
    on<Wronganswer>((event, emit) => emit(Colors.red));
    on<Correctanswer>((event, emit) => emit(Colors.green));
  }
}

// List color = [Colors.black, Colors.red, Colors.blue];
