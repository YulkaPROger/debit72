import 'package:debit72/widgets/home/previous-button.dart';
import 'package:debit72/widgets/home/previous_icon.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../pages/nav_bar.dart';
import '../widgets/home/previous.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   @override
  void initState() {
    super.initState();
    showDialogIfFirstLoaded(context);
  }

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

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String apiKey = prefs.getString('APIkey')?? "APIkey dont find";
    TextEditingController apiController = TextEditingController();
    TextEditingController dataController = TextEditingController();
    if (apiKey == "APIkey dont find") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Пожалуйста, введите ваше ФИО и дату рождения"),
            content: Column(
              children: [
                TextField(
                    onChanged: (textSearch) {},
                    controller: apiController,
                    decoration: InputDecoration(
                      hintText: "ФИО",
                      prefixIcon: Icon(Icons.search),
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(25)))
                    ),
                  ),
                  TextField(
                    onChanged: (textSearch) {},
                    controller: dataController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      hintText: "Дата рождения",
                      prefixIcon: Icon(Icons.search),
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(25)))
                    ),
                  ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () async {
                  await prefs.setString('APIkey', apiController.text);
                  await prefs.setString('Birthday', dataController.text);

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
