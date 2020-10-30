import 'package:shared_preferences/shared_preferences.dart';

import 'pages/search_avto_RT.dart';

import 'pages/avto.dart';
import 'pages/home.dart';
import 'pages/ip_detail.dart';
import 'pages/ip_page.dart';
import 'pages/jow_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      },
    );
  }
}

//           return MaterialApp(
//             initialRoute: 'home_page',
//             routes: <String, WidgetBuilder>{
//               // When navigating to the "/" route, build the FirstScreen widget.
//               'home_page': (context) => HomePage(),
//               'jow': (context) => MyJOW(),
//               'ip': (context) => IPScreen(),
//               'ipDetail': (context) => IPDetail(),
//               'avto': (context) => Avto(),
//               'search_avto_real_time': (context) => CameraPreviewScanner(),
//             },

//             debugShowCheckedModeBanner: false,

//             title: 'App for Arest',
//           );

//   }
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: NavBar(),
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
