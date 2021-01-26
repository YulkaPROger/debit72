import 'avto.dart';
import 'busines.dart';
import 'employer.dart';
import 'property.dart';
import 'settlement_accounts.dart';

class IPDetail {
  String lineNumberOfTabExcel;
  double totalDebtAmount;
  double remainingDebt;
  var remainingFSSP;
  String canceled;
  String reasonForCancellation;
  String periodS;
  String periodBefore;
  String dateOfApplication;
  String wakeDate;
  String completionDateIP;
  String regNumber;
  String productionStatus;
  String codesVKSP;
  String spi;
  String typeID;
  String bailiffDepartment;
  String dateID;
  String numberID;
  String caseNumber;
  String street;
  String house;
  String apartment;
  String debitor;
  String debitorStreet;
  String debitorHouse;
  String debitorApartment;
  String debitorBirthday;
  String debitorPensioner;
  String debitorBirthplace;
  String dead;
  String ls;
  String adressFact;
  String solidarity;
  String solidarityFace;
  List<Avto> avto;
  List<Property> property;
  List<Busines> busines;
  List<Employer> employer;
  List<SetlementAccounts> setlementsAccounts;

  IPDetail(
      {this.lineNumberOfTabExcel,
      this.totalDebtAmount,
      this.remainingDebt,
      this.remainingFSSP,
      this.canceled,
      this.reasonForCancellation,
      this.periodS,
      this.periodBefore,
      this.dateOfApplication,
      this.wakeDate,
      this.completionDateIP,
      this.regNumber,
      this.productionStatus,
      this.codesVKSP,
      this.spi,
      this.typeID,
      this.bailiffDepartment,
      this.dateID,
      this.numberID,
      this.caseNumber,
      this.street,
      this.house,
      this.apartment,
      this.debitor,
      this.debitorStreet,
      this.debitorHouse,
      this.debitorApartment,
      this.debitorBirthday,
      this.debitorPensioner,
      this.debitorBirthplace,
      this.dead,
      this.ls,
      this.adressFact,
      this.solidarity,
      this.solidarityFace,
      this.avto,
      this.property,
      this.busines,
      this.employer,
      this.setlementsAccounts});

  factory IPDetail.fromJson(Map<String, dynamic> jsonMap) {
    final List<dynamic> avto = jsonMap['Авто'];
    List<Avto> avtoList = avto.map((json) => Avto.fromJson(json)).toList();

    final List<dynamic> prop = jsonMap['Имущество'];
    List<Property> propList =
        prop.map((json) => Property.fromJson(json)).toList();

    final List<dynamic> busines = jsonMap['ИмуществоЕГРЮЛ'];
    List<Busines> businesList =
        busines.map((json) => Busines.fromJson(json)).toList();

    final List<dynamic> employer = jsonMap['Работодатели'];
    List<Employer> employerList =
        employer.map((json) => Employer.fromJson(json)).toList();

    final List<dynamic> setlementsAccounts = jsonMap['РасчетныеСчета'];
    List<SetlementAccounts> setlementsAccountsList = setlementsAccounts
        .map((json) => SetlementAccounts.fromJson(json))
        .toList();

    double debtAmount = double.parse(jsonMap['ОбщаяСуммаДолга']);
    double debtRemaining = double.parse(jsonMap['ОстатокДолга']);

    return IPDetail(
        lineNumberOfTabExcel: jsonMap['НомерСтрокиИзТабExcel'],
        totalDebtAmount: debtAmount,
        remainingDebt: debtRemaining,
        remainingFSSP: jsonMap['ОстатокФССП'],
        canceled: jsonMap['Аннулировано'],
        reasonForCancellation: jsonMap['ПричинаАннуляции'],
        periodS: jsonMap['ПериодС'],
        periodBefore: jsonMap['ПериодДо'],
        dateOfApplication: jsonMap['ДатаПодачи'],
        wakeDate: jsonMap['ДатаВозбуждения'],
        completionDateIP: jsonMap['ДатаЗавершенияИп'],
        regNumber: jsonMap['РегНомерИП'],
        productionStatus: jsonMap['СтатусПроизводства'],
        codesVKSP: jsonMap['КодыВКСП'],
        spi: jsonMap['СПИ'],
        typeID: jsonMap['ТипИД'],
        bailiffDepartment: jsonMap['ОрганВыдавшийИД'],
        dateID: jsonMap['ДатаИД'],
        numberID: jsonMap['НомерИД'],
        caseNumber: jsonMap['НомерДела'],
        street: jsonMap['ФондСПрРодитель'],
        house: jsonMap['ФондСПр'],
        apartment: jsonMap['КвартираФонда'],
        debitor: jsonMap['Должник'],
        debitorStreet: jsonMap['ДолжникФондСправочникРодитель'],
        debitorHouse: jsonMap['ДолжникФондСправочник'],
        debitorApartment: jsonMap['ДолжникКвартираФонда'],
        debitorBirthday: jsonMap['ДолжникДР'],
        debitorPensioner: jsonMap['ДолжникПенсионер'],
        debitorBirthplace: jsonMap['ДолжникМестоРождения'],
        dead: jsonMap['Умер'],
        ls: jsonMap['ЛицевойСчет'],
        adressFact: jsonMap['ДолжникАдресФактический'],
        solidarity: jsonMap['Солидарно'],
        solidarityFace: jsonMap['СписокСолидарщиков'],
        avto: avtoList,
        property: propList,
        busines: businesList,
        employer: employerList,
        setlementsAccounts: setlementsAccountsList);
  }
}
