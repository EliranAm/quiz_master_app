import 'package:flutter/material.dart';

class DashBoardCard extends StatelessWidget {
  DashBoardCard({this.title, this.icon, this.onPressed});

  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FlatButton(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 32.0,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}