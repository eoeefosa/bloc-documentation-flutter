// // Define your quiz events
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class QuizEvent {}

// class QuizStarted extends QuizEvent {}

// class QuizAnswered extends QuizEvent {
//   final String answer;
//   QuizAnswered(this.answer);
// }

// class QuizTimeout extends QuizEvent {}

// class QuizFinished extends QuizEvent {}




// //TODO: QUIZSTATE Define your quiz states
// abstract class QuizState {}

// class QuizLoading extends QuizState {}

// class QuizLoaded extends QuizState {
//   final Question question;
//   final int timeLeft;
//   QuizLoaded(this.question, this.timeLeft);
// }

// class QuizCorrect extends QuizState {
//   final Question question;
//   final int score;
//   final int timeLeft;
//   QuizCorrect(this.question, this.score, this.timeLeft);
// }

// class QuizWrong extends QuizState {
//   final Question question;
//   final String answer;
//   final int score;
//   final int timeLeft;
//   QuizWrong(this.question, this.answer, this.score, this.timeLeft);
// }

// class QuizComplete extends QuizState {
//   final int score;
//   QuizComplete(this.score);
// }

// // Define your quiz bloc
// class QuizBloc extends Bloc<QuizEvent, QuizState> {
//   // Initialize your quiz data and timer
//   List<Question> questions = [...];
//   int currentIndex = 0;
//   int score = 0;
//   late Timer timer;

//   // Define your initial state
//   @override
//   QuizState get initialState => QuizLoading();

//   // Map events to states
//   @override
//   Stream<QuizState> mapEventToState(QuizEvent event) async* {
//     if (event is QuizStarted) {
//       // Load the first question and start the timer
//       yield* _loadQuestion();
//     } else if (event is QuizAnswered) {
//       // Check the answer and update the score
//       yield* _checkAnswer(event.answer);
//     } else if (event is QuizTimeout) {
//       // Show the correct answer and update the score
//       yield* _showCorrectAnswer();
//     } else if (event is QuizFinished) {
//       // Show the final score
//       yield QuizComplete(score);
//     }
//   }

//   // Helper method to load a question
//   Stream<QuizState> _loadQuestion() async* {
//     // Get the current question
//     Question question = questions[currentIndex];
//     // Reset the timer
//     timer?.cancel();
//     timer = Timer(Duration(seconds: 30), () {
//       // Dispatch a timeout event if time runs out
//       add(QuizTimeout());
//     });
//     // Emit a loaded state with the question and time left
//     yield QuizLoaded(question, timer.tick);
//   }

//   // Helper method to check an answer
//   Stream<QuizState> _checkAnswer(String answer) async* {
//     // Get the current question
//     Question question = questions[currentIndex];
//     // Cancel the timer
//     timer?.cancel();
//     // Compare the answer with the correct one
//     if (answer == question.correctAnswer) {
//       // Increase the score and emit a correct state
//       score++;
//       yield QuizCorrect(question, score, timer.tick);
//     } else {
//       // Emit a wrong state with the user's answer
//       yield QuizWrong(question, answer, score, timer.tick);
//     }
//     // Wait for a second before loading the next question or finishing the quiz
//     await Future.delayed(Duration(seconds: 1));
//     // Check if there are more questions
//     if (currentIndex < questions.length - 1) {
//       // Increment the index and load the next question
//       currentIndex++;
//       yield* _loadQuestion();
//     } else {
//       // Dispatch a finished event
//       add(QuizFinished());
//     }
//   }

//   // Helper method to show the correct answer
//   Stream<QuizState> _showCorrectAnswer() async* {
//     // Get the current question
//     Question question = questions[currentIndex];
//     // Cancel the timer
//     timer?.cancel();
//     // Emit a wrong state with the correct answer
//     yield QuizWrong(question, question.correctAnswer, score, timer.tick);
//     // Wait for a second before loading the next question or finishing the quiz
//     await Future.delayed(Duration(seconds: 1));
//     // Check if there are more questions
//     if (currentIndex < questions.length - 1) {
//       // Increment the index and load the next question
//       currentIndex++;
//       yield* _loadQuestion();
//     } else {
//       // Dispatch a finished event
//       add(QuizFinished());
//     }
//   }

//   // Dispose the timer when bloc is closed
//   @override
//   Future<void> close() {
//     timer?.cancel();
//     return super.close();
//   }
// }

// // Define your quiz UI
// class QuizPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => QuizBloc()..add(QuizStarted()),
//       child: BlocBuilder<QuizBloc, QuizState>(
//         builder: (context, state) {
//           if (state is QuizLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is QuizLoaded) {
//             return _buildQuizView(context, state);
//           } else if (state is QuizCorrect) {
//             return _buildQuizView(context, state);
//           } else if (state is QuizWrong) {
//             return _buildQuizView(context, state);
//           } else if (state is QuizComplete) {
//             return _buildResultView(context, state);
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }

//   // Helper method to build the quiz view
//   Widget _buildQuizView(BuildContext context, QuizState state) {
//     // Get the bloc instance
//     QuizBloc bloc = BlocProvider.of<QuizBloc>(context);
//     // Get the current question and time left from the state
//     Question question = state.question;
//     int timeLeft = state.timeLeft;
//     // Define some colors for different states
//     Color defaultColor = Colors.grey;
//     Color correctColor = Colors.green;
//     Color wrongColor = Colors.red;
//     // Define a function to get the container color based on the answer and state
//     Color getContainerColor(String answer) {
//       if (state is QuizCorrect && answer == question.correctAnswer) {
//         return correctColor;
//       } else if (state is QuizWrong && answer == question.correctAnswer) {
//         return correctColor;
//       } else if (state is QuizWrong && answer == state.answer) {
//         return wrongColor;
//       } else {
//         return defaultColor;
//       }
//     }

//     // Return a scaffold with a timer and a list of options
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz App'),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//               child: Text(
//                 '$timeLeft s',
//                 style: TextStyle(fontSize: 24),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               question.question,
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 16),
//             ...question.options.map((option) {
//               return GestureDetector(
//                 onTap: () {
//                   // Dispatch an answered event with the user's answer
//                   bloc.add(QuizAnswered(option));
//                 },
//                 child: Container(
//                   margin: EdgeInsets.all(8),
//                   width: 200,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: getContainerColor(option),
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: Text(option),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper method to build the result view
//   Widget _buildResultView(BuildContext context, QuizState state) {
//     // Get the final score from the state
//     // Get the final score from the state
//     int score = state.score;
//     // Return a scaffold with a congratulation message and a restart button
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz App'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Congratulations!',
//               style: TextStyle(fontSize: 32),
//             ),
//             Text(
//               'You scored $score out of 10',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Restart the quiz by dispatching a started event
//                 bloc.add(QuizStarted());
//               },
//               child: Text('Restart'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
