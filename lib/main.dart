import 'package:flutter/services.dart';

import 'models/theme_model.dart';
import 'pages/home.dart';
import 'pages/ip_page.dart';
import 'pages/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProviderModel()),
        ChangeNotifierProvider<ThemeModel>(
          create: (_) => ThemeModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider<ThemeModel>(
        create: (BuildContext context) => ThemeModel(),
        child: Consumer<ThemeModel>(builder: (context, model, __) {
          return MaterialApp(
            initialRoute: 'home_page',
            routes: <String, WidgetBuilder>{
              // When navigating to the "/" route, build the FirstScreen widget.
              'home_page': (context) => HomePage(),
              // '/jow': (context) => MyJOW(),
              'ip': (context) => IPScreen(),
              // '/ipDetail': (context) => IPDetail(),
              // '/avto': (context) => Avto(),
            },
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              dividerColor: model.dividerColor,
              textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: model.textColor, displayColor: model.textColor),
              appBarTheme: AppBarTheme(color: model.appbarcolor),
              primaryColor: model.primaryMainColor,
              accentColor: model.accentColor,
            ),
            title: 'Flutter Multi Theme',
          );
        }));
  }
}

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
