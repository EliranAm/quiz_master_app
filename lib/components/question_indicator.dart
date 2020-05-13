import 'package:flutter/material.dart';

class QuestionIndicator extends StatelessWidget {
  QuestionIndicator({this.color, this.number});

  final number;
  final color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
        child: CircleAvatar(
          backgroundColor: color,
          child: Text(
            '$number',
            style: TextStyle(
              color: color == Colors.white
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
