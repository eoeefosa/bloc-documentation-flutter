import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quizbloc.dart';
import '../questions.dart';

List<Question> questions = <Question>[
  Question(
      question: "What is the capital of France?",
      options: ["Paris", "Bordeaux", "Nice", "Lyon"],
      correctanswer: 2),
  Question(
      question: "What is the capital of France?",
      options: ["Paris", "Bordeaux", "Nice", "Lyon"],
      correctanswer: 2),
  Question(
      question: "What is the capital of France?",
      options: ["Paris", "Bordeaux", "Nice", "Lyon"],
      correctanswer: 2),
];

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => QuizBloc(questions)..add(Quizstarted()),
    child: BlocBuilder<QuizBloc,QuizState>(builder:((context, state) {
      if(state is QuizInitial){
        return const Center(child:  CircularProgressIndicator(),);
      }else if (state is Quizloaded){
        return _buildQuizView(context, state);
      }else if(state is QuizCorrectAnswer){
        return
      }else if(state is QuizWrongAnswer){
        return
      }else if(state is QuizComplete){
        return
      }
    }) ),);
  }
}

Widget _buildQuizView(BuildContext context, QuizState state){
  QuizBloc bloc =BlocProvider.of<QuizBloc>(context);
  Question question =state.question;
  return getContainerColor(String answer){
    if(state is Q)
  }
}

class QuizSce extends StatelessWidget {
  const QuizSce({super.key});

  @override
  Widget build(BuildContext context) {
    final question=context.select((QuizBloc bloc)=> bloc.state)
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Screen")),
      body:  Column(
        children: [
          Container(child: const Text(),)
        ],
      ),
    );
  }
}