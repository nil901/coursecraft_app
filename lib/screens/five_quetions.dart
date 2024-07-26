import 'package:flutter/material.dart';
import 'dart:math';

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}

class QuestionScreen2 extends StatefulWidget {
  @override
  _QuestionScreen2State createState() => _QuestionScreen2State();
}

class _QuestionScreen2State extends State<QuestionScreen2> {
  String? _selectedAnswer;
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  bool _showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    _generateRandomQuestions();
  }

  void _generateRandomQuestions() {
    List<Question> allQuestions = [
      Question("What is the capital of France?", ["Paris", "London", "Berlin", "Madrid"], "Paris"),
      Question("What is the capital of Spain?", ["Paris", "London", "Berlin", "Madrid"], "Madrid"),
      Question("What is the capital of Germany?", ["Paris", "London", "Berlin", "Madrid"], "Berlin"),
      Question("What is the capital of England?", ["Paris", "London", "Berlin", "Madrid"], "London"),
      Question("What is the capital of Italy?", ["Rome", "Paris", "Berlin", "Madrid"], "Rome"),
      Question("What is the capital of Japan?", ["Tokyo", "Paris", "Berlin", "Madrid"], "Tokyo"),
      // Add more questions as needed
    ];

    allQuestions.shuffle();
    _questions = allQuestions.take(5).toList();
  }

  void _handleAnswerSelection(String value) {
    setState(() {
      _selectedAnswer = value;
      _showCorrectAnswer = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You selected: $_selectedAnswer'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Choice Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              currentQuestion.questionText,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...currentQuestion.options.map((option) => RadioListTile<String>(
                  title: Text(
                    option,
                    style: TextStyle(
                      color: _showCorrectAnswer && option == currentQuestion.correctAnswer
                          ? Colors.green
                          : _selectedAnswer == option
                              ? Colors.red
                              : null,
                    ),
                  ),
                  value: option,
                  groupValue: _selectedAnswer,
                  onChanged: _selectedAnswer == null
                      ? (value) => _handleAnswerSelection(value!)
                      : null,
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showCorrectAnswer
                  ? () {
                      if (_currentQuestionIndex < _questions.length - 1) {
                        setState(() {
                          _selectedAnswer = null;
                          _showCorrectAnswer = false;
                          _currentQuestionIndex++;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Quiz completed!'),
                          ),
                        );
                      }
                    }
                  : null,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
