import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:debit72/models/avto_list.dart';
import 'package:debit72/models/avto_list_ip.dart';
import 'package:debit72/models/provider.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

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
        'http://109.194.162.125/debit72/hs/debit72/avtoID?APIkey=$apiKey&StateNumber=$resultScan');
    // print(response.body);
    if (response.statusCode == 200) {
      //декодировать в UTF-8 иначе приходят каракули
      String body = utf8.decode(response.bodyBytes);
      final List<dynamic> avtoList = json.decode(body);
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
            // String text = results.text;
            for (TextBlock block in results.blocks) {
              final String text =
                  block.text.toUpperCase().replaceAll(RegExp(' +'), '');
              //print("block.text===========================$text");
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

  Widget _buildImage(theme, provider) {


    return Container(
      child: _camera == null
          ? const Center(
              child: Text(
                'Инициализация камеры...',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 30.0,
                ),
              ),
            )
          : Stack(
              fit: StackFit.loose,
              children: <Widget>[
                AspectRatio(aspectRatio: 12/16,
                child: CameraPreview(_camera)
                ),
                _buildResults(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: isSearcing == false ? 9 : 4,
                      child: Container(),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                            color: theme.buttonColor,
                            child: Text(
                              "$resultScan",
                              style: TextStyle(
                                  color: isSearcing == false
                                      ? Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black
                                      : Colors.redAccent,
                                  fontSize: 30),
                            ))),
                    isSearcing == false
                        ? Container()
                        : Expanded(
                            flex: 5,
                            child: Container(
                              color: theme.buttonColor,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.car_rental,
                                      color: Colors.redAccent,
                                    ),
                                    title: Text(avtoListSearch[0].debitor),
                                    subtitle: InkWell(
                                      onTap: () {
                                        print("tap ========================================================================");
                                        var nameDebitor = avtoListSearch[0].debitor;
                                        provider.setNameDebitor(name: nameDebitor);
                                        Navigator.pushNamed(context, 'avto');

                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "ТС: ${avtoListSearch[0].debitorVehicles}"),
                                          Text(
                                              "Фонд: ул.${avtoListSearch[0].street}, дом ${avtoListSearch[0].house}, кв. ${avtoListSearch[0].apartment}"),
                                          Text(
                                              "ИП: ${avtoListSearch[0].ipList.length} штук"),
                                          Text(
                                              "На сумму: ${getTotalDebt(avtoListSearch[0].ipList)} руб."),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    width: double.maxFinite,
                                    padding: EdgeInsets.only(top: 8),
                                    margin: EdgeInsets.only(right: 8),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            avtoListSearch[0].ipList.length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return Stack(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  var ipDetail =
                                                      avtoListSearch[0]
                                                          .ipList[i]
                                                          .numberIP
                                                          .toString();
                                                  provider.setNumID(
                                                      numForSetNumID: ipDetail);
                                                  print(ipDetail);
                                                  Navigator.of(context)
                                                      .pushNamed('ipDetail');
                                                },
                                                child: Container(
                                                  width: 170,
                                                  padding:
                                                      EdgeInsets.only(left: 16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(avtoListSearch[0]
                                                          .ipList[i]
                                                          .claimant),
                                                      Text(
                                                          "Остаток: ${avtoListSearch[0].ipList[i].remainingDebt}"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 80,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                    color: Colors.redAccent,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8))),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ],
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
    var theme = Theme.of(context);
    ProviderModel provider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.buttonColor,
      ),
      body: _buildImage(theme, provider),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: theme.accentColor,
      //   onPressed: _toggleCameraDirection,
      //   child: _direction == CameraLensDirection.back
      //       ? const Icon(Icons.camera_front)
      //       : const Icon(Icons.camera_rear),
      // ),
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

  getTotalDebt(List<AvtoIPList> ip) {
    double sum = 0.0;
    for (var i = 0; i < ip.length; i++) {
      try {
        var num1 = double.parse(ip[i].remainingDebt);
        sum = sum + num1;
      } catch (e) {
        print(e);
      }
    }
    String sum1 = sum.toString();
    var sum2 = double.parse(sum1).toStringAsFixed(2);
    return sum2.toString();
  }
}
