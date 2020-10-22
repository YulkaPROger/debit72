import 'package:flutter/material.dart';

class ProviderModel extends ChangeNotifier {
  String _numID;

  String get numID => _numID;

  setNumID({String numForSetNumID}) {
    _numID = numForSetNumID.replaceAll(RegExp(r"\s+\b|\b\s"), "");
    notifyListeners();
  }
}
