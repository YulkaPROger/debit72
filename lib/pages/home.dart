import 'package:debit72/theme/settings.dart';
import 'package:provider/provider.dart';

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
          IconButton(
            icon: Icon(Provider.of<Settings>(context).isDarkMode
                ? Icons.brightness_high
                : Icons.brightness_low),
            onPressed: () {
              changeTheme(
                  Provider.of<Settings>(context, listen: false).isDarkMode
                      ? false
                      : true,
                  context);
            },
          ),
        ],
      )),
    );
  }
}

void changeTheme(bool set, BuildContext context) {
  /// Вызов метода setDarkMode внутри нашего Settings ChangeNotifier
  /// класс для уведомления всех слушателей изменения.
  Provider.of<Settings>(context, listen: false).setDarkMode(set);
}
