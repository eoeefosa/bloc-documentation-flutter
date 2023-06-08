// // Define your quiz event class
// import 'dart:async';

// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class QuizEvent extends Equatable {
//   const QuizEvent();

//   @override
//   List<Object> get props => [];
// }

// class AnswerQuestion extends QuizEvent {
//   final int answer;

//   const AnswerQuestion(this.answer);

//   @override
//   List<Object> get props => [answer];
// }

// class NextQuestion extends QuizEvent {}

// class ResetQuiz extends QuizEvent {}

// // Define your quiz state class
// abstract class QuizState extends Equatable {
//   const QuizState();

//   @override
//   List<Object> get props => [];
// }

// class QuizInitial extends QuizState {}

// class QuizLoading extends QuizState {}

// class QuizLoaded extends QuizState {
//   final int questionIndex;
//   final int score;
//   final int timeLeft;

//   const QuizLoaded(this.questionIndex, this.score, this.timeLeft);

//   @override
//   List<Object> get props => [questionIndex, score, timeLeft];
// }

// class QuizFinished extends QuizState {
//   final int score;

//   const QuizFinished(this.score);

//   @override
//   List<Object> get props => [score];
// }

// // Define your quiz bloc class
// class QuizBloc extends Bloc<QuizEvent, QuizState> {
//   // Define some mock data for questions and answers
//   final List<String> questions = [
//     "What is the capital of France?",
//     "What is the largest animal?",
//     "Who wrote Hamlet?",
//     "What is 2 + 2?"
//   ];

//   final List<List<String>> options = [
//     ["Paris", "Berlin", "London", "Rome"],
//     ["Elephant", "Whale", "Giraffe", "Dinosaur"],
//     ["Shakespeare", "Hemingway", "Tolstoy", "Orwell"],
//     ["4", "22", "5", "3"]
//   ];

//   final List<int> answers = [0, 1, 0, 0];

//   // Define some constants for timer and score
//   static const int maxTime = 30;
//   static const int maxScore = 10;

//   // Define a timer field
//   Timer _timer;

//   // Initialize the bloc with an initial state
//   QuizBloc() : super(QuizInitial());

//   @override
//   Stream<QuizState> mapEventToState(QuizEvent event) async* {
//     // If the event is reset quiz, yield a loading state and then a loaded state with initial values
//     if (event is ResetQuiz) {
//       yield QuizLoading();
//       _timer.cancel();
//       await Future.delayed(const Duration(seconds: 1));
//       _startTimer();
//       yield const QuizLoaded(0, 0, maxTime);
//     }
//     // If the event is answer question, check the answer and update the score accordingly
//     else if (event is AnswerQuestion) {
//       _timer.cancel();
//       int questionIndex = (state as QuizLoaded).questionIndex;
//       int score = (state as QuizLoaded).score;
//       if (event.answer == answers[questionIndex]) {
//         score += maxScore;
//       }
//       yield QuizLoaded(questionIndex, score, 0);
//     }
//     // If the event is next question, check if there are more questions and yield a new state with the next question or a finished state
//     else if (event is NextQuestion) {
//       int questionIndex = (state as QuizLoaded).questionIndex;
//       int score = (state as QuizLoaded).score;
//       if (questionIndex < questions.length - 1) {
//         questionIndex++;
//         _startTimer();
//         yield QuizLoaded(questionIndex, score, maxTime);
//       } else {
//         yield QuizFinished(score);
//       }
//     }
//   }

//   // Define a helper method to start the timer and dispatch events based on the time left
//   void _startTimer() {
//     int timeLeft = maxTime;
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       timeLeft--;
//       add(NextQuestion());
//       if (timeLeft == 0) {
//         timer.cancel();
//       }
//     });
//   }

//   // Override the close method to cancel the timer
//   @override
//   Future<void> close() {
//     _timer.cancel();
//     return super.close();
//   }
// }

// // Define your quiz widget class
// class QuizWidget extends StatefulWidget {
//   const QuizWidget({Key key}) : super(key: key);

//   @override
//   _QuizWidgetState createState() => _QuizWidgetState();
// }

// class _QuizWidgetState extends State<QuizWidget> {
//   // Define a bloc field
//   QuizBloc _bloc;

//   // Define a list of colors for the options
//   final List<Color> _colors = [
//     Colors.transparent,
//     Colors.transparent,
//     Colors.transparent,
//     Colors.transparent
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the bloc and dispatch a reset event
//     _bloc = QuizBloc();
//     _bloc.add(ResetQuiz());
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Use a BlocBuilder to listen to state changes and rebuild the widget accordingly
//     return BlocBuilder<QuizBloc, QuizState>(
//         bloc: _bloc,
//         builder: (context, state) {
//           // If the state is initial, show a welcome message and a start button
//           if (state is QuizInitial) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Welcome to the quiz app!"),
//                   ElevatedButton(
//                     onPressed: () => _bloc.add(ResetQuiz()),
//                     child: const Text("Start"),
//                   ),
//                 ],
//               ),
//             );
//           }
//           // If the state is loading, show a loading indicator
//           else if (state is QuizLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           // If the state is loaded, show the question, options, timer and score
//           else if (state is QuizLoaded) {
//             return Column(
//               children: [
//                 Text("Question ${state.questionIndex + 1}"),
//                 Text(_bloc.questions[state.questionIndex]),
//                 ..._bloc.options[state.questionIndex]
//                     .asMap()
//                     .entries
//                     .map((entry) => GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               // Change the color of the selected option based on the answer
//                               if (entry.key ==
//                                   _bloc.answers[state.questionIndex]) {
//                                 _colors[entry.key] = Colors.green;
//                               } else {
//                                 _colors[entry.key] = Colors.red;
//                               }
//                             });
//                             // Dispatch an answer event with the selected option
//                             _bloc.add(AnswerQuestion(entry.key));
//                           },
//                           child: Container(
//                             color: _colors[entry.key],
//                             child: Text(entry.value),
//                           ),
//                         ))
//                     .toList(),
//                 Text("Time left: ${state.timeLeft}"),
//                 Text("Score: ${state.score}"),
//                 ElevatedButton(
//                   onPressed: () => _bloc.add(NextQuestion()),
//                   child: const Text("Next"),
//                 ),
//               ],
//             );
//           }
//           // If the state is finished, show the final score and a reset button
//           else if (state is QuizFinished) {
//             return Center(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("You finished the quiz!"),
//                 Text("Your score is ${state.score}"),
//                 ElevatedButton(
//                   onPressed: () => _bloc.add(ResetQuiz()),
//                   child: const Text("Reset"),
//                 ),
//               ],
//             ));
//           }
//         });
//   }
// }
