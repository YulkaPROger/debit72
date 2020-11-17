import 'package:flutter/material.dart';

class ProviderModel extends ChangeNotifier {
  String _numID;

  String get numID => _numID;

  setNumID({String numForSetNumID}) {
    _numID = numForSetNumID.replaceAll(RegExp(r"\s+\b|\b\s"), "");
    notifyListeners();
  }

  String _nameDebitor = "";

  String get nameDebitor => _nameDebitor;

  setNameDebitor({String name}) {
    _nameDebitor = name;
    notifyListeners();
  }
}
