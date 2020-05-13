import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({@required this.title, @required this.onPressed, this.color});

  final String title;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          padding: EdgeInsets.all(15),
          onPressed: onPressed,
          minWidth: 200.0,
          height: 60.0,
          child: Text(
            title,
            textAlign: TextAlign.center, // TODO: set direction
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}