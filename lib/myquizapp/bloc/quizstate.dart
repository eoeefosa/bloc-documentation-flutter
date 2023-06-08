part of 'quizbloc.dart';

sealed class QuizState {
  const QuizState();
}

final class QuizInitial extends QuizState {
  const QuizInitial({required this.question, required this.timeLeft});
  final Question question;
  final int timeLeft;

  // @override
  // String toString() {
  // return 'QuizInitial { Questions: $question timeleft:$timeLeft}';
  // }
}

class Quizloaded extends QuizState {
  final Question question;
  final int timeleft;
  Quizloaded(this.question, this.timeleft);
}

final class QuizCorrectAnswer extends QuizState {
  final Question question;
  final int score;
  final int timeLeft;
  const QuizCorrectAnswer(
      {required this.question, required this.score, required this.timeLeft});
}

final class QuizWrongAnswer extends QuizState {
  const QuizWrongAnswer({
    required this.question,
    required this.answer,
    required this.score,
    required this.timeLeft,
  });
  final Question question;
  final int answer;
  final int score;
  final int timeLeft;
}

final class QuizComplete extends QuizState {
  final int score;
  QuizComplete({required this.score});
}

// final class CompleteQuiz extends QuizState {
//   // const CompleteQuiz() : super();
// }
