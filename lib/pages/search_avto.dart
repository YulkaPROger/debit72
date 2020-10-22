import 'package:flutter/material.dart';

class SearchAvto extends StatefulWidget {
  @override
  _SearchAvtoState createState() => _SearchAvtoState();
}

class _SearchAvtoState extends State<SearchAvto> {
  bool isInizilized = false;

  @override
  void initState() {
    super.initState();
  }

  void _startScan() async {}

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
