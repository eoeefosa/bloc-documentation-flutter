import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Step 2: Define the quiz question model
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}

// Step 5: Create the QuizBloc
enum QuizEvent {
  OptionSelected,
  TimerExpired,
}

class QuizState {
  final bool isTimerExpired;
  final int? selectedOptionIndex;
  final int correctOptionIndex;

  QuizState({
    required this.isTimerExpired,
    this.selectedOptionIndex,
    required this.correctOptionIndex,
  });
}

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizQuestion question;
  late Timer _timer;
  late int _remainingSeconds;

  QuizBloc({required this.question}) : super(QuizState(
        isTimerExpired: false,
        correctOptionIndex: question.correctOptionIndex,
      )) {
    _startTimer();
  }

  void _startTimer() {
    _remainingSeconds = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _remainingSeconds--;
      if (_remainingSeconds <= 0) {
        add(QuizEvent.TimerExpired);
      }
    });
  }

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event == QuizEvent.TimerExpired) {
      _timer.cancel();
      yield QuizState(
        isTimerExpired: true,
        selectedOptionIndex: null,
        correctOptionIndex: state.correctOptionIndex,
      );
    } else if (event == QuizEvent.OptionSelected) {
      _timer.cancel();
      yield QuizState(
        isTimerExpired: false,
        selectedOptionIndex: question.correctOptionIndex,
        correctOptionIndex: state.correctOptionIndex,
      );
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}

// Step 3: Create the quiz screen UI
class QuizScreen extends StatelessWidget {
  final QuizQuestion question;

  QuizScreen({required this.question});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (_) => QuizBloc(question: question),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    question.question,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ...question.options
                    .asMap()
                    .entries
                    .map(
                      (entry) => OptionContainer(
                        optionIndex: entry.key,
                        text: entry.value,
                        isSelected: state.selectedOptionIndex == entry.key,
                        isCorrect: entry.key == question.correctOptionIndex,
                      ),
                    )
                    .toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Step 4: Implement the timer
class OptionContainer extends StatelessWidget {
  final int optionIndex;
  final String text;
  final bool isSelected;
  final bool isCorrect;

  OptionContainer({
    required this.optionIndex,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<QuizBloc>(context);
    final color = isSelected
        ? isCorrect
            ? Colors.green
            : Colors.red
        : Colors.white;

    return GestureDetector(
      onTap: () {
        if (!bloc.state.isTimerExpired) {
          bloc.add(QuizEvent.OptionSelected);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(12),
        color: color,
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: QuizScreen(
        question: QuizQuestion(
          question: 'What is the capital of France?',
          options: ['London', 'Paris', 'Berlin', 'Madrid'],
          correctOptionIndex: 1,
        ),
      ),
    );
  }
}
