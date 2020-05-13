import 'package:flutter/material.dart';
import 'package:quizmasterapp/constants.dart';
import 'package:quizmasterapp/screens/conclusion_screen.dart';
import 'package:quizmasterapp/screens/dashboard_screen.dart';
import 'package:quizmasterapp/screens/questions_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'VarelaRound',
        backgroundColor: Colors.blueGrey.shade900,
        primarySwatch: Colors.teal,
        accentColor: Color(0xffa5a515),
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            textTheme: ButtonTextTheme.primary),
      ),
      initialRoute: DashboardScreen.id,
      routes: {
        DashboardScreen.id: (context) => DashboardScreen(),
        QuestionsScreen.id: (context) => QuestionsScreen(),
        ConclusionScreen.id: (context) => ConclusionScreen(),
      },
    );
  }
}
