import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_jamel/flutter_mobile_vision_jamel.dart';

class SearchAvto extends StatefulWidget {
  @override
  _SearchAvtoState createState() => _SearchAvtoState();
}

class _SearchAvtoState extends State<SearchAvto> {
  bool isInizilized = false;

  @override
  void initState() {
    super.initState();
    FlutterMobileVision.start().then((value) => isInizilized = true);
  }

  void _startScan() async {
    List<OcrText> list = List();
    try {
      list =
          await FlutterMobileVision.read(waitTap: true, fps: 5, multiple: true);
      for (OcrText text in list) {
        print(text.value);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("SEARCH"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startScan();
        },
      ),
    );
  }
}
