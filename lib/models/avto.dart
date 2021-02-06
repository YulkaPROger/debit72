class Avto {
  String avto;
  String stateNumber;
  String model;
  bool arrested;
  bool realised;
  String dateArrested;
  String amountEstimated;
  String storage;
  Avto({this.avto, this.model, this.stateNumber, this.arrested, this.realised, this.dateArrested, this.amountEstimated, this.storage});

  factory Avto.fromJson(Map<String, dynamic> json) {
    print(json);
    return Avto(
      avto: json['Авто'],
      stateNumber: json['ГосномерТС'],
      model: json['МодельТС'],
      arrested: json['Аретовано'],
      realised: json['Реализован'],
      dateArrested: json['ДатаАрестаТС'],
      amountEstimated: json['СуммаПоОценкеТС'],
      storage: json['МестоХранения']
    );
  }
}