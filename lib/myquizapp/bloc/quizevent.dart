part of 'quizbloc.dart';

sealed class QuizEvent {}

class Quizstarted extends QuizEvent {}

class QuizAnswered extends QuizEvent {
  final int answeredindex;
  QuizAnswered({required this.answeredindex});
}

class QuizFinished extends QuizEvent {}

class QuizTimeout extends QuizEvent {}
