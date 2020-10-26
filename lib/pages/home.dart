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
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'avto');
            },
            child: Text("Автомобили"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'jow');
            },
            child: Text("Судебно-приказная работа"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'search_avto_real_time');
            },
            child: Text("Поиск авто real-time"),
          ),
          Previous(),
        ],
      )),
    );
  }
}
