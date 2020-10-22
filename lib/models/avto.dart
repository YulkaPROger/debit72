class Avto {
  String avto;
  String stateNumber;
  String model;
  Avto({this.avto, this.model, this.stateNumber});

  factory Avto.fromJson(Map<String, dynamic> json) {
    print(json);
    return Avto(
      avto: json['Авто'],
      stateNumber: json['ГосномерТС'],
      model: json['МодельТС']
      
    );
  }
}