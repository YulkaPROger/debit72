import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/avto_list.dart';
import '../models/ip.dart';
import '../models/ip_detail.dart';
import '../models/judicial_order_work.dart';
import '../models/previous_info.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Api {
  //Получаем данные Исполнительного производства с сервера
  Future<List<Info>> getPreviusInfo() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String apiKey = prefs.getString('APIkey') ?? "APIkey dont find";

    final response = await http.get(
        'http://109.194.162.125/debit/hs/debit72/PreviousInfo?APIkey=$apiKey');
    print(response);
    if (response.statusCode == 200) {
      //декодировать в UTF-8 иначе приходят каракули
      String body = utf8.decode(response.bodyBytes);
      // print(body);
      final List<dynamic> infoJSON = json.decode(body);
      return infoJSON.map((json) => Info.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching judical order work');
    }
  }

  //Получаем данные Исполнительного производства из JSON (локальный файл)
  Future<List<IP>> getAllIDfromJSON() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = await File("$appDocPath/ip.json");
    String fileContent = await file.readAsString();
    String jsonResponse = json.decode(fileContent);
    print(jsonResponse.runtimeType);

    // String responseBody = await rootBundle.loadString('assets/JSON/ip.json');
    if (fileContent.toString() != null) {
      final List<dynamic> ipJSON = json.decode(jsonResponse);
      return ipJSON.map((json) => IP.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching judical order work');
    }
  }

  //Получаем данные Исполнительного производства с сервера и записываем в JSON
  Future<List<IP>> getAllID() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String apiKey = prefs.getString('APIkey') ?? "APIkey dont find";

    final response = await http
        .get('http://109.194.162.125/debit/hs/debit72/IP?APIkey=$apiKey');
    print(response);
    if (response.statusCode == 200) {
      //декодировать в UTF-8 иначе приходят каракули
      String body = utf8.decode(response.bodyBytes);

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      File file = await File("$appDocPath/ip.json").create();
      String fileContent = json.encode(body);
      file.writeAsString(fileContent);

      final List<dynamic> ipJSON = json.decode(body);
      return ipJSON.map((json) => IP.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching judical order work');
    }
  }

  //Получаем данные Судебно-приказной работы с локального хранилища
  Future<List<JOW>> getJudicalOrderWorkJSON() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File("$appDocPath/jow.json");
    String fileContent = await file.readAsString();
    String jsonResponse = json.decode(fileContent);
    print(jsonResponse.runtimeType);

    // String responseBody = await rootBundle.loadString('assets/JSON/ip.json');
    if (fileContent.toString() != null) {
      final List<dynamic> judicalJSON = json.decode(jsonResponse);
      return judicalJSON.map((json) => JOW.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching judical order work');
    }
  }
  //   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //   final SharedPreferences prefs = await _prefs;
  //   final String apiKey = prefs.getString('APIkey') ?? "APIkey dont find";

  //   final response = await http
  //       .get('http://109.194.162.125/debit/hs/debit72/PostJSON?APIkey=$apiKey');
  //   if (response.statusCode == 200) {
  //     //декодировать в UTF-8 иначе приходят каракули
  //     String body = utf8.decode(response.bodyBytes);
  //     // print(body);
  //     final List<dynamic> judicalJSON = json.decode(body);
  //     return judicalJSON.map((json) => JOW.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Error fetching judical order work');
  //   }
  // }

  //Получаем данные Судебно-приказной работы с сервера и записываем в локальный файл
  Future<List<JOW>> getJudicalOrderWork() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String apiKey = prefs.getString('APIkey') ?? "APIkey dont find";

    final response = await http
        .get('http://109.194.162.125/debit/hs/debit72/PostJSON?APIkey=$apiKey');
    if (response.statusCode == 200) {
      //декодировать в UTF-8 иначе приходят каракули
      String body = utf8.decode(response.bodyBytes);

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      File file = await File("$appDocPath/jow.json").create();
      String fileContent = json.encode(body);
      file.writeAsString(fileContent);

      // print(body);
      final List<dynamic> judicalJSON = json.decode(body);
      return judicalJSON.map((json) => JOW.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching judical order work');
    }
  }

  //Детальные данные по исполнительному производству
  Future<List<IPDetail>> getDetailIPData({String number}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String apiKey = prefs.getString('APIkey') ?? "APIkey dont find";
    int intID = int.parse(number);

    final response = await http.get(
        'http://109.194.162.125/debit/hs/debit72/linkIP?APIkey=$apiKey&link=$intID');
    if (response.statusCode == 200) {
      //декодировать в UTF-8 иначе приходят каракули
      String body = utf8.decode(response.bodyBytes);

      final List<dynamic> ipDetail = json.decode(body);

      return ipDetail.map((json) => IPDetail.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching judical order work');
    }
  }

//Получаем данные авто с сервера и записываем в локальный файл
  Future<List<AvtoList>> getAvtoListFromJSON() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File("$appDocPath/avto.json");
    String fileContent = await file.readAsString();
    String jsonResponse = json.decode(fileContent);
    print(jsonResponse.runtimeType);

    // String responseBody = await rootBundle.loadString('assets/JSON/ip.json');
    if (fileContent.toString() != null) {
      final List<dynamic> avtoList = json.decode(jsonResponse);
      return avtoList.map((json) => AvtoList.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching judical order work');
    }
  }
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     final SharedPreferences prefs = await _prefs;
//     final String apiKey = prefs.getString('APIkey') ?? "APIkey dont find";

//     final response = await http
//         .get('http://109.194.162.125/debit/hs/debit72/avtoAll?APIkey=$apiKey');
//     // print(response.body);
//     if (response.statusCode == 200) {
//       //декодировать в UTF-8 иначе приходят каракули
//       String body = utf8.decode(response.bodyBytes);

//       final List<dynamic> avtoList = json.decode(body);
//       return avtoList.map((json) => AvtoList.fromJson(json)).toList();
//     } else {
//       throw Exception('Error fetching judical order work');
//     }
//   }
// }

//Получаем данные авто с сервера и записываем в локальный файл
  Future<List<AvtoList>> getAvtoList() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String apiKey = prefs.getString('APIkey') ?? "APIkey dont find";

    final response = await http
        .get('http://109.194.162.125/debit/hs/debit72/avtoAll?APIkey=$apiKey');
    // print(response.body);
    if (response.statusCode == 200) {
      //декодировать в UTF-8 иначе приходят каракули
      String body = utf8.decode(response.bodyBytes);

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      File file = await File("$appDocPath/avto.json").create();
      String fileContent = json.encode(body);
      file.writeAsString(fileContent);

      final List<dynamic> avtoList = json.decode(body);
      return avtoList.map((json) => AvtoList.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching judical order work');
    }
  }
}
