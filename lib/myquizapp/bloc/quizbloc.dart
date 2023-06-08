import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../questions.dart';

part 'quizstate.dart';
part 'quizevent.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final List<Question> questions;
  int currentindex = 0;
  int score = 0;
  Timer? timer;

  // Question question=question[currentindex];
  // static const int _timeleft =30;
  QuizBloc(this.questions) : super(QuizInitial()) {
    on<Quizstarted>(_loadquestion);
    on<QuizAnswered>(_checkAnswer);
    on<QuizTimeout>(_showCorrectAnswer);
    on<QuizFinished>(((event, emit) => emit(QuizComplete(score: score))));
  }

  QuizState _loadquestion(Quizstarted event, Emitter<QuizState> emit) {
    Question question = questions[currentindex];
    timer?.cancel();
    timer = Timer(const Duration(seconds: 30), () {
      add(QuizTimeout());
    });
    return Quizloaded(question, timer!.tick);
  }

  Stream<QuizState> _load() async* {
    Question question = questions[currentindex];
    timer?.cancel();
    timer = Timer(const Duration(seconds: 30), () {
      add(QuizTimeout());
    });
    yield Quizloaded(question, timer!.tick);
  }

  Stream<QuizState> _checkAnswer(
      QuizAnswered event, Emitter<QuizState> emit) async* {
    Question question = questions[currentindex];
    timer?.cancel();

    if (event.answeredindex == question.correctanswer) {
      score++;
      yield QuizCorrectAnswer(
        question: question,
        score: score,
        timeLeft: timer!.tick,
      );
    } else {
      yield QuizWrongAnswer(
        question: question,
        answer: question.correctanswer,
        score: score,
        timeLeft: timer!.tick,
      );
    }

    await Future.delayed(const Duration(milliseconds: 500));

    if (currentindex < questions.length - 1) {
      currentindex++;
      yield* _load();
    } else {
      add(QuizFinished());
    }
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  void _showCorrectAnswer(QuizTimeout event, Emitter<QuizState> emit) {}
}
