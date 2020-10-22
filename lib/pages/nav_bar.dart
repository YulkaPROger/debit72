import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  TextEditingController apiController = TextEditingController();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _getAPIkey() async {
    final SharedPreferences prefs = await _prefs;
    final String apiKey = prefs.getString('APIkey') ?? "APIkey dont find";

    apiController.text = apiKey.toString();
  }

  @override
  void initState() {
    super.initState();
    _getAPIkey();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                onChanged: (textSearch) {},
                controller: apiController,
                decoration: InputDecoration(
                  hintText: "Поиск",
                  prefixIcon: Icon(Icons.search),
                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(25)))
                ),
              ),
            RaisedButton(

                onPressed: () async {
                  final SharedPreferences prefs = await _prefs;
                  prefs.setString('APIkey', apiController.text);
                },
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Save",
                  ),
            )
          ],
        ),
      )
    );
  }
}
