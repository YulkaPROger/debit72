class Avto {
  String avto;
  String stateNumber;
  String model;
  String arrested;
  Avto({this.avto, this.model, this.stateNumber, this.arrested});

  factory Avto.fromJson(Map<String, dynamic> json) {
    print(json);
    return Avto(
      avto: json['Авто'],
      stateNumber: json['ГосномерТС'],
      model: json['МодельТС'],
      arrested: json['Аретовано']
      
    );
  }
}