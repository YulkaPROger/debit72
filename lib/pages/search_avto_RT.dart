import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';

class RealTimeSearchAvto extends StatefulWidget {
  @override
  _RealTimeSearchAvtoState createState() => _RealTimeSearchAvtoState();
}

class _RealTimeSearchAvtoState extends State<RealTimeSearchAvto> {
  List<String> data = [];
  final _scanKey = GlobalKey<CameraMlVisionState>();
  BarcodeDetector detector = FirebaseVision.instance.barcodeDetector();
  TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraMlVision<List<Barcode>>(
            key: _scanKey,
            detector: detector.detectInImage,
            resolution: ResolutionPreset.high,
            onResult: (barcodes) {
              if (barcodes == null ||
                  barcodes.isEmpty ||
                  data.contains(barcodes.first.displayValue) ||
                  !mounted) {
                return;
              }
              setState(() {
                data.add(barcodes.first.displayValue);
              });
            },
            onDispose: () {
              detector.close();
            },
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 250),
                  child: Scrollbar(
                    child: ListView(
                      children: data.map((d) {
                        return Container(
                          color: Color(0xAAFFFFFF),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(d),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        _scanKey.currentState.toggle();
                      },
                      child: Text('Start/Pause camera'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
