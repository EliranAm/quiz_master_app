import 'package:flutter/material.dart';
import 'package:quizmasterapp/screens/dashboard_screen.dart';

class ConclusionScreen extends StatefulWidget {
  static String id = 'conclusion';

  @override
  _ConclusionScreenState createState() => _ConclusionScreenState();
}

class _ConclusionScreenState extends State<ConclusionScreen> {
  @override
  Widget build(BuildContext context) {
    final int _score = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiple Choice Quiz"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed(DashboardScreen.id);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            'You scored $_score points!',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
