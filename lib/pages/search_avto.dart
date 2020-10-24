import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SearchAvto extends StatefulWidget {
  @override
  _SearchAvtoState createState() => _SearchAvtoState();
}

class _SearchAvtoState extends State<SearchAvto> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future readText() async {
    print("function ReadText");
    try {
      FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(_image);
      TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
      VisionText readText = await recognizeText.processImage(ourImage);

      for (TextBlock block in readText.blocks) {
        print(block.toString());
        for (TextLine line in block.lines) {
          print(line.toString());
          for (TextElement word in line.elements) {
            print(word.text);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Container(height: 200, width: 200, child: Image.file(_image)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                child: Icon(Icons.add),
                onPressed: getImage,
              ),
              RaisedButton(
                child: Icon(Icons.read_more),
                onPressed: readText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
