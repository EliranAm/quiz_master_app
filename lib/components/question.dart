import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmasterapp/components/question_data.dart';
import 'package:quizmasterapp/components/rounded_button.dart';
import 'package:quizmasterapp/constants.dart';

class Question extends StatelessWidget {
  Question({@required this.data, this.stopTimer});

  final Map data;
  final Function stopTimer;

  void _selectAnswer(questionData, index) {
    if (questionData.selectedAnswer == null) {
      if (questionData.selectAnswer(data['answers'][index])) {
        questionData.setColorByIndex(kSelectedAnswerColor, index);
        if (stopTimer != null) {
          stopTimer();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
      elevation: 5.0,
      color: Colors.white,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Text(
                data['question'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ), // Question
            Expanded(
              child: Consumer<QuestionData>(
                builder: (context, questionData, child) {
                  return ListView.builder(
                    itemCount: data['answers'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 2.0),
                        child: RoundedButton(
                          title: '${data['answers'][index]}',
                          onPressed: questionData.selectedAnswer == null &&
                                  questionData.canAnswer == true
                              ? () {
                                  _selectAnswer(questionData, index);
                                }
                              : null,
                          color: questionData.colors[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ), // Answers
            Container(
              margin: EdgeInsets.only(left: 20, right: 20.0, bottom: 20.0),
              alignment: Alignment.center,
              color: Colors.white,
              child: Text(
                Provider.of<QuestionData>(context).userFeedback,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ), // User answer feedback
          ],
        ),
      ),
    );
  }
}
