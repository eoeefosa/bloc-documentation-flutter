import 'package:blocdocplay/puredart/readandwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'acontainerplay/app.dart';
import 'acontainerplay/bloc/acontainerbloc.dart';
import 'counterexample/counterbloc.dart';
import 'counterexample/counterexample.dart';
import 'execisecounter/colorcontainer.dart';
import 'execisecounter/exercise.dart';
import 'flutter_infinite_list/app.dart';
import 'flutter_infinite_list/simple_bloc_observer.dart';

void main() {
  runApp(const Learning());
}

class Learning extends StatelessWidget {
  const Learning({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ThemeData(
      //   primaryColor: const Color.fromRGBO(109, 234, 255, 1),
      //   colorScheme: const ColorScheme.light(
      //     secondary: Color.fromRGBO(72, 74, 126, 1),
      //   ),
      // ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        children: [
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: const Text("Counter app "),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BlocProvider(
                  create: (_) => CounterBloc(),
                  child: const CounterPage(),
                );
              }));
            },
          ),
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: const Text("ContainerColorpage "),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BlocProvider(
                  create: (_) => ContainerColorBloc(),
                  child: const ContainerColorpage(),
                );
              }));
            },
          ),
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: const Text("Quizcontianer app "),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return BlocProvider(
                      create: (_) => ContainerBloc(),
                      child: const AcontainerQuiz());
                }),
              );
            },
          ),
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: const Text("Email form"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return (const SignForm());
                }),
              );
            },
          ),
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: const Text("Infinite list"),
            onTap: () {
              Bloc.observer = const SimpleBlocObserver();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return (const App());
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
