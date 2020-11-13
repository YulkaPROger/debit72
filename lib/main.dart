import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/search_avto_RT.dart';
import 'pages/avto.dart';
import 'pages/home.dart';
import 'pages/ip_detail.dart';
import 'pages/ip_page.dart';
import 'pages/jow_page.dart';
import 'pages/claimant.dart';


import 'models/provider.dart';
import 'theme/settings.dart';
import 'theme/themes.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProviderModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        return ChangeNotifierProvider<Settings>.value(
          value: Settings(snapshot.data),
          child: _MyApp(),
        );
      },
    );
  }
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<Settings>(context).isDarkMode
          ? setDarkTheme
          : setLightTheme,
      initialRoute: 'home_page',
      routes: <String, WidgetBuilder>{
        // When navigating to the "/" route, build the FirstScreen widget.
        'home_page': (context) => HomePage(),
        'jow': (context) => MyJOW(),
        'ip': (context) => IPScreen(),
        'ipDetail': (context) => IPDetail(),
        'avto': (context) => Avto(),
        'search_avto_real_time': (context) => CameraPreviewScanner(),
        'claimant': (context) => Claimant(),
      },
    );
  }
}