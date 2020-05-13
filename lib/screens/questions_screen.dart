import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';
import 'package:quizmasterapp/components/question.dart';
import 'package:quizmasterapp/components/question_data.dart';
import 'package:quizmasterapp/components/questions_list.dart';
import 'package:quizmasterapp/components/score_keeper.dart';
import 'package:quizmasterapp/constants.dart';
import 'package:quizmasterapp/screens/conclusion_screen.dart';

class QuestionsScreen extends StatefulWidget {
  static String id = 'questions';

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  int _userScore = 0;
  ScoreKeeper _scoreKeeper;
  QuestionList _questionList = QuestionList();
  QuestionData _questionData = QuestionData();

  Duration _timeLeftWhenAnswer;
  Duration _timeLeft = Duration(seconds: kSecondsPerQuestion);
  intl.NumberFormat _timeFormat;
  CountdownTimer _countDownTimer;

  AnimationController controller;
  Animation animation;
  var particlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;

  void _checkWhenTimeout() async {
    // Prevent user from answering after time ended
    _questionData.setCanAnswerFlag(false);

    // Check answer
    String correctAnswer =
        _questionList.getQuestion(_questionData.questionNumber)['correct'];
    if (_questionData.selectedAnswer == correctAnswer) {
      _questionData.setColor(Colors.green[400], _questionData.selectedAnswer);
      _questionData.setUserFeedback(kCorrectFeedback);
      _calculateScore();
      _scoreKeeper.setAnswer(true);
    } else {
      _questionData.setColor(Colors.green[400], correctAnswer);
      _questionData.setColor(Colors.red[400], _questionData.selectedAnswer);
      _questionData.setUserFeedback(kWrongFeedback);
      _scoreKeeper.setAnswer(false);
    }

    // Wait for user to see the answer
    await new Future.delayed(const Duration(seconds: kSecondsBetweenQuestions));

    // Move to next question
    _moveToNextQuestion();
  }

  void _moveToNextQuestion() {
    if (_questionData.questionNumber < _questionList.numOfQuestion - 1) {
      // Move to next question
      _questionData.incrementQuestionNumber();
      _questionData.updateQuestionData(
          _questionList.getQuestion(_questionData.questionNumber));
      _scoreKeeper.setQuestion(_questionData.questionNumber);

      // Reset animation controller
      controller.reset();
      controller.forward();

      setState(() {
        // Reset timer
        _countDownTimer.cancel();
        _timeLeft = Duration(seconds: kSecondsPerQuestion);
        _startTimer();
      });
    } else {
      Navigator.pushNamed(context, ConclusionScreen.id, arguments: _userScore);
    }
  }

  void _calculateScore() {
    int pointsPerTime = (_timeLeftWhenAnswer.inMilliseconds / 10).round();
    int addPoints = pointsPerTime > kMinimumTimePoints ? pointsPerTime: kMinimumTimePoints;
    _userScore += kBasePoints + addPoints;
  }

  void _startTimer() {
    _timeFormat = intl.NumberFormat("00", "en_US");

    _countDownTimer = new CountdownTimer(
      new Duration(seconds: kSecondsPerQuestion),
      new Duration(milliseconds: 100),
    );

    var sub = _countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _timeLeft = Duration(
          milliseconds: kMilliInSecond * kSecondsPerQuestion - duration.elapsed.inMilliseconds,
          //seconds: kSecondsPerQuestion - duration.elapsed.inSeconds,
        );
      });
    });

    sub.onDone(() {
      sub.cancel();
      _checkWhenTimeout();
    });
  }

  void _initBarAnimation() {
    controller = AnimationController(
      duration: Duration(seconds: kSecondsPerQuestion),
      upperBound: 1.0,
      vsync: this,
    );

    animation =
        ColorTween(begin: Colors.green, end: Colors.red).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    _scoreKeeper = ScoreKeeper(
      numOfQuestions: _questionList.numOfQuestion,
    );

    _startTimer();
    _initBarAnimation();
    _questionData.updateQuestionData(
        _questionList.getQuestion(_questionData.questionNumber));
  }

  @override
  void dispose() {
    _countDownTimer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuestionData>(
      create: (context) => _questionData,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: kParticleOptionsWhite,
            paint: particlePaint,
          ),
          vsync: this,
          child: Container(
            alignment: Alignment.center,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _scoreKeeper,
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      bottom: 20.0,
                      top: 10.0,
                    ),
                    child: Text(
                      'ניקוד: $_userScore',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.white,
                      ),
                    ),
                  ), // Score
                  Expanded(
                    child: Question(
                      data: _questionList
                          .getQuestion(_questionData.questionNumber),
                      stopTimer: () {
                        _timeLeftWhenAnswer = _timeLeft;
                      },
                    ),
                  ), // Question
                  Container(
                    margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
                    alignment: Alignment.center,
                    child: Text(
                      '00:${_timeFormat.format(_timeLeft.inSeconds)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 26.0),
                    ),
                  ), // Timer
                  Container(
                    height: 24.0,
                    width: MediaQuery.of(context).size.width -
                        (MediaQuery.of(context).size.width * controller.value),
                    child: Container(
                      color: animation.value,
                    ),
                  ), // Left time bar
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
