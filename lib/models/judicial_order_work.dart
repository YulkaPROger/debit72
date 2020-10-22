// Judical Order Work
class JOW {
  String date;
  String court;
  String hearingCourt;
  String claimant;
  String defendants;
  String street;
  String house;
  String apartment;

  JOW({this.date, this.court, this.hearingCourt, this.claimant, this.defendants, this.street, this.house, this.apartment});

  factory JOW.fromJson(Map<String, dynamic> json){

    return JOW(
      date: json['ДатаПодачиЗаявления'],
      court: json['Суд'],
      hearingCourt: json['СудРассматривающийЗаявление'],
      claimant: json['Взыскатель'],
      defendants: json['НаКогоПодаемВСуд'],
      street: json['ФондРодитель'],
      house: json['Фонд'],
      apartment: json['КвартираФонда'],
    );

  }
}