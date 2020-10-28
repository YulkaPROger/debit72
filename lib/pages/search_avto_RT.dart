import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:debit72/models/avto_list.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detector_painters.dart';
import 'scaner_utils.dart';
import 'package:http/http.dart' as http;

class CameraPreviewScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CameraPreviewScannerState();
}

class _CameraPreviewScannerState extends State<CameraPreviewScanner> {
  dynamic _scanResults;
  CameraController _camera;
  Detector _currentDetector = Detector.text;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.back;
  String resultScan;
  bool isSearcing = false;
  int searchNum = 0;
  List<AvtoList> avtoListSearch;
  var search;

  final TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<List<AvtoList>> getAvtoList() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String apiKey = prefs.getString('APIkey') ?? "APIkey dont find";

    final response = await http.get(
        'http://109.194.162.125/debit/hs/debit72/avtoID?APIkey=$apiKey&StateNumber=$resultScan');
    // print(response.body);
    if (response.statusCode == 200) {
      //декодировать в UTF-8 иначе приходят каракули
      String body = utf8.decode(response.bodyBytes);
      print("body");
      print(body);
      final List<dynamic> avtoList = json.decode(body);
      // print("ipDetail");
      // print(avtoList);
      // print("${ipDetail[0]}");
      // print(ipDetail[0]);
      setState(() {
        if (avtoList.length > 0) {
          isSearcing = true;
        }
      });

      avtoListSearch = avtoList.map((json) => AvtoList.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching judical order work');
    }
  }

  void _initializeCamera() async {
    final CameraDescription description =
        await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      defaultTargetPlatform == TargetPlatform.iOS
          ? ResolutionPreset.low
          : ResolutionPreset.medium,
    );
    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      ScannerUtils.detect(
        image: image,
        detectInImage: _getDetectionMethod(),
        imageRotation: description.sensorOrientation,
      ).then(
        (dynamic results) {
          if (_currentDetector == null) return;
          setState(() {
            String text = results.text;
            for (TextBlock block in results.blocks) {
              final String text =
                  block.text.toUpperCase().replaceAll(RegExp(' +'), '');
              print("block.text===========================$text");
              // проверка на соответствие номеру
              try {
                //RegExp exp = RegExp(r"^\w?(\d{3})(\w{2}(\d{2,3})?)?");
                RegExp exp = RegExp(r"[A-Z]\d{3}[A-Z]{2}\d{2,3}");
                Iterable<Match> matches = exp.allMatches(text);

                matches.forEach((key) {
                  print("searh=======");
                  print(text.substring(key.start, key.end));
                  String scan = text.substring(key.start, key.end);
                  if (resultScan != scan) {
                    resultScan = scan;
                    isSearcing = false;
                    search = getAvtoList();
                    print(search.toString());
                  }
                });
              } catch (e) {
                print(e);
              }
            }
            _scanResults = results;
          });
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }

  Future<dynamic> Function(FirebaseVisionImage image) _getDetectionMethod() {
    return _recognizer.processImage;
  }

  Widget _buildResults() {
    const Text noResultsText = Text('No results!');

    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return noResultsText;
    }

    CustomPainter painter;

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );

    painter = TextDetectorPainter(imageSize, _scanResults);
    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(
              child: Text(
                'Initializing Camera...',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                ),
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CameraPreview(_camera),
                _buildResults(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: isSearcing == false?9:4,
                      child: Container(),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                            color: Colors.white,
                            child: Text(
                              "$resultScan",
                              style: TextStyle(
                                  color: isSearcing == false
                                      ? Colors.black
                                      : Colors.red,
                                  fontSize: 36),
                            ))),
                    isSearcing == false
                        ? Container()
                        : Expanded(
                            flex: 4,
                            child: Container(
                              color: Colors.white,
                              child: ListTile(
                                leading: Icon(
                                  Icons.car_rental,
                                  color: Colors.red,
                                ),
                                title: Text(avtoListSearch[0].debitor),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Арестовано: ${avtoListSearch[0].arestoredTS}"),
                                    Text(
                                        "ИП по которому арестовано: ${avtoListSearch[0].ipArested}"),
                                    Text(
                                        "Место хранения: ${avtoListSearch[0].storageLocation}"),
                                    Text(
                                        "Комментарий: ${avtoListSearch[0].commentCar}"),
                                    Text(
                                        "Cумма по оценке: ${avtoListSearch[0].ammountTS}"),
                                    Text(
                                        "Фонд: ул.${avtoListSearch[0].street}, дом ${avtoListSearch[0].house}, кв. ${avtoListSearch[0].apartment}"),
                                    Text(
                                        "ТС: ${avtoListSearch[0].debitorVehicles}"),
                                  ],
                                ),
                              ),
                            )),
                  ],
                )
              ],
            ),
    );
  }

  void _toggleCameraDirection() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }

    await _camera.stopImageStream();
    await _camera.dispose();

    setState(() {
      _camera = null;
    });

    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildImage(),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleCameraDirection,
        child: _direction == CameraLensDirection.back
            ? const Icon(Icons.camera_front)
            : const Icon(Icons.camera_rear),
      ),
    );
  }

  @override
  void dispose() {
    _camera.dispose().then((_) {
      _recognizer.close();
    });

    _currentDetector = null;
    super.dispose();
  }
}
