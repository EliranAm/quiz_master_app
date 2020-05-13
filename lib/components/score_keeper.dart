import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmasterapp/components/question_data.dart';
import 'package:quizmasterapp/components/question_indicator.dart';
import 'package:quizmasterapp/constants.dart';

class ScoreKeeper extends StatefulWidget {
  ScoreKeeper({@required this.numOfQuestions});

  final numOfQuestions;
  final _ScoreKeeperState state = _ScoreKeeperState();

  void setQuestion(int questionNumber) {
    state.setQuestion(questionNumber);
  }

  void setAnswer(bool isCorrect) {
    return state.setAnswer(isCorrect);
  }

  @override
  _ScoreKeeperState createState() {
    return state;
  }
}

class _ScoreKeeperState extends State<ScoreKeeper> {
  List<QuestionIndicator> _scoreKeeper;

  void setQuestion(int questionNumber) {
    // Check input validity
    if (questionNumber >= 0 && questionNumber < _scoreKeeper.length) {
      // Update UI
      setState(() {
        _scoreKeeper[questionNumber] = QuestionIndicator(
          color: kSelectedAnswerColor,
          number: questionNumber + 1,
        );
      });
    }
  }

  void setAnswer(bool isCorrect) {
    // Set color as default to correct answer
    Color color = Colors.green;
    int questionNumber = Provider.of<QuestionData>(context).questionNumber;

    // if the answer is false, change color to red
    if (isCorrect == false) {
      color = Colors.red;
    }

    // Update UI
    setState(() {
      _scoreKeeper[questionNumber] = QuestionIndicator(
        color: color,
        number: questionNumber + 1,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _scoreKeeper = List.generate(
      widget.numOfQuestions,
      (index) => QuestionIndicator(
        color: index > 0 ? Colors.white : kSelectedAnswerColor,
        number: index + 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _scoreKeeper,
      ),
    );
  }
}
