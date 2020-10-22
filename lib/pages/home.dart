import '../pages/nav_bar.dart';
import '../widgets/home/previous.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      body: SafeArea(
          child: Column(
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'ip');
            },
            child: Text("Исполнительное производство"),
          ),
          Previous(),
        ],
      )),
    );
  }
}
