import 'package:debit72/widgets/home/previous-button.dart';
import 'package:debit72/widgets/home/previous_icon.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


import '../pages/nav_bar.dart';
import '../widgets/home/previous.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      drawer: NavBar(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PreviousIcon(
                theme: theme,
                icons: MaterialCommunityIcons.account_badge,
              ),
              ButtonMenu(
                theme: theme,
                textButton: "Исполнительное\nпроизводство",
                textPages: 'ip',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonMenu(
                theme: theme,
                textButton: "Автомобили",
                textPages: 'avto',
              ),
              PreviousIcon(
                theme: theme,
                icons: Ionicons.ios_car,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PreviousIcon(
                theme: theme,
                icons: FontAwesome.legal,
              ),
              ButtonMenu(
                theme: theme,
                textButton: "Судебно-приказная\nработа",
                textPages: 'jow',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonMenu(
                theme: theme,
                textButton: "Взыскатели",
                textPages: 'claimant',
              ),
              PreviousIcon(theme: theme, icons: MaterialCommunityIcons.account_group),
              
              
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              PreviousIcon(theme: theme, icons: Ionicons.ios_search),
              ButtonMenu(
                theme: theme,
                textButton: "Поиск авто\nreal-time",
                textPages: 'search_avto_real_time',
              ),
            ],
          ),
          
          Previous(),
        ],
      )),
    );
  }
}
