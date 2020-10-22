import 'avto_list_ip.dart';

class AvtoList {
  String debitor;
  String debitorVehicles;
  String modelTS;
  String numberTS;
  String arestoredTS;
  String dateOfArrest;
  String storageLocation;
  String ammountTS;
  String salesStatus;
  String commentCar;
  String ipArested;
  String tsRealized;
  String apartment;
  String house;
  String street;
  String searchString;
  List<AvtoIPList> ipList;

  AvtoList(
      {this.debitor,
      this.debitorVehicles,
      this.modelTS,
      this.numberTS,
      this.arestoredTS,
      this.dateOfArrest,
      this.storageLocation,
      this.ammountTS,
      this.salesStatus,
      this.commentCar,
      this.ipArested,
      this.tsRealized,
      this.apartment,
      this.house,
      this.street,
      this.searchString,
      this.ipList});

  factory AvtoList.fromJson(Map<String, dynamic> jsonMap) {
    final List<dynamic> ip = jsonMap['ИП'];
    List<AvtoIPList> ipList =
        ip.map((json) => AvtoIPList.fromJson(json)).toList();

    return AvtoList(
        debitor: jsonMap['Владелец'],
        debitorVehicles: jsonMap['ТранспортныеСредстваДолжника'],
        modelTS: jsonMap['МодельТС'],
        numberTS: jsonMap['ГосномерТС'],
        arestoredTS: jsonMap['ТСАрестован'],
        dateOfArrest: jsonMap['ДатаАрестаТС'],
        storageLocation: jsonMap['МестоХранения'],
        ammountTS: jsonMap['СуммаПоОценкеТС'],
        salesStatus: jsonMap['СтатусРеализацииТС'],
        commentCar: jsonMap['КомментарииАвтомобили'],
        ipArested: jsonMap['ИПпоКоторомуАрестованоТС'],
        tsRealized: jsonMap['ТСРеализован'],
        apartment: jsonMap['ВладелецКвартираФонда'],
        house: jsonMap['ВладелецДомФонда'],
        street: jsonMap['ВладелецУлицаФонда'],
        searchString: jsonMap['строкаПоиска'],
        ipList: ipList);
  }
}
