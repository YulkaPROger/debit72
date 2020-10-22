// Judical Order Work
class IP {
  String numberID;
  String caseNumber;
  String defendants;
  String claimant;
  String street;
  String house;
  String apartment;
  String bailiff;
  String bailiffDepartment;
  String link;

  IP(
      {this.numberID,
      this.caseNumber,
      this.defendants,
      this.claimant,
      this.street,
      this.house,
      this.apartment,
      this.bailiff,
      this.bailiffDepartment,
      this.link});

  factory IP.fromJson(Map<String, dynamic> json) {
    return IP(
      numberID: json['НомерИД'],
      caseNumber: json['НомерДела'],
      defendants: json['Должник'],
      claimant: json['Взыскатель'],
      street: json['ФондСПрРодитель'],
      house: json['ФондСПр'],
      apartment: json['КвартираФонда'],
      bailiffDepartment: json['КодыВКСП'],
      bailiff: json['СПИ'],
      link: json['Номер']
      
    );
  }
}