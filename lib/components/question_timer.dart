import 'package:quiver/async.dart';
import 'package:quizmasterapp/constants.dart';
import 'package:intl/intl.dart' as intl;

class QuestionTimer {
  QuestionTimer({this.onData, this.onDone});

  final Function onData;
  final Function onDone;

  int _secondsToAnswer = 0;
  int _secondsLeft = kSecondsPerQuestion;
  intl.NumberFormat _timeFormat;
  CountdownTimer _countDownTimer;

  String get formattedTime => '00:${_timeFormat.format(_secondsLeft)}';

  void startTimer() {
    _timeFormat = intl.NumberFormat("00", "en_US");

    _countDownTimer = new CountdownTimer(
      new Duration(seconds: kSecondsPerQuestion),
      new Duration(seconds: 1),
    );

    var sub = _countDownTimer.listen(null);
    sub.onData((duration) {
      _secondsLeft = kSecondsPerQuestion - duration.elapsed.inSeconds;
    });

    sub.onDone(() {
      sub.cancel();
      onDone();
    });
  }

  void resetTimer() {
    _countDownTimer?.cancel();
    _secondsLeft = kSecondsPerQuestion;
    _secondsToAnswer = 0;

    startTimer();
  }

  void dispose() {
    _countDownTimer.cancel();
  }
}