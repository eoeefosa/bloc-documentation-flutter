class Question {
  final String question;
  final List<String> options;
  final int correctanswer;

  Question({
    required this.question,
    required this.options,
    required this.correctanswer,
  });

  @override
  String toString() {
    return '{Question :$question \n :$options}';
  }
}

class Asker {
  const Asker();

  Stream<Question> ask({required List<Question> question}) {
    return Stream.periodic(const Duration(seconds: 1),
        (x) => question[question.length - x - 1]).take(question.length);
  }
}
