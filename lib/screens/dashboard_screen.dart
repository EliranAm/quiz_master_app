import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quizmasterapp/components/dashboard_card.dart';
import 'package:quizmasterapp/screens/questions_screen.dart';

class DashboardScreen extends StatefulWidget {
  static String id = 'dashboard';

  @override
  State<StatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[dashBg, content],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).primaryColor,
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.settings, size: 30),
          Icon(Icons.list, size: 35),
          Icon(Icons.info_outline, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
    );
  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Container(color: Theme.of(context).primaryColor),
            flex: 2,
          ),
          Expanded(
            child: Container(color: Colors.transparent),
            flex: 5,
          ),
        ],
      );

  get content => Container(
        child: Column(
          children: <Widget>[
            header,
            grid,
          ],
        ),
      );

  get header => ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 30),
        title: Text(
          'Full Name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          '42625 points',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        trailing: CircleAvatar(
          radius: 26,
          child: Icon(
            Icons.supervised_user_circle,
            size: 40.0,
          ),
        ),
      );

  get grid => Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: GridView.count(
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 2,
            childAspectRatio: .90,
            children: <Widget>[
              DashBoardCard(
                title: 'History',
                icon: Icons.history,
                onPressed: () {},
              ),
              DashBoardCard(
                title: 'Leadeboard',
                icon: Icons.recent_actors,
                onPressed: () {},
              ),
              DashBoardCard(
                title: 'Setting',
                icon: Icons.settings,
                onPressed: () {},
              ),
              DashBoardCard(
                title: 'Start Quiz',
                icon: Icons.play_circle_outline,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    QuestionsScreen.id,
                  );
                },
              ),
            ],
          ),
        ),
      );
}


