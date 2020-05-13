import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:quizmasterapp/constants.dart';

class QuestionData extends ChangeNotifier {
  String _selectedAnswer;
  int _questionNumber = 0;
  bool _canAnswer = true;
  String _userFeedback = '';
  List<Color> _colors = List.filled(4, kAnswersColor);
  Map _data;

  String get selectedAnswer => _selectedAnswer;
  int get questionNumber => _questionNumber;
  bool get canAnswer => _canAnswer;
  String get userFeedback => _userFeedback;
  UnmodifiableListView<Color> get colors => UnmodifiableListView(_colors);

  bool selectAnswer(String newAnswer) {
    if (_canAnswer) {
      _selectedAnswer = newAnswer;
      notifyListeners();
    }
    return _canAnswer;
  }

  void updateQuestionData(newData) {
    _data = newData;
    _selectedAnswer = null;
    _canAnswer = true;
    _userFeedback = '';
    _colors.fillRange(0, _data['answers'].length, kAnswersColor);
    notifyListeners();
  }

  void incrementQuestionNumber() {
    ++_questionNumber;
    notifyListeners();
  }

  void resetQuestionNumber() {
    _questionNumber = 0;
    notifyListeners();
  }

  void setCanAnswerFlag(bool newValue) {
    _canAnswer = newValue;
    notifyListeners();
  }

  void setUserFeedback(String newValue) {
    _userFeedback = newValue;
    notifyListeners();
  }

  void setColor(Color newColor, String answer) {
    int index = _data['answers'].indexOf(answer);
    if (index >= 0) {
      setColorByIndex(newColor, index);
    }
  }

  void setColorByIndex(Color newColor, int index) {
    if (index >= 0 && index < _colors.length) {
      _colors[index] = newColor;
      notifyListeners();
    }
  }
}
