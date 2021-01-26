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
  String regNumberIP;
  String sumDebt;
  String remainderDebt;
  String fullAdress;

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
      this.link,
      this.regNumberIP,
      this.sumDebt,
      this.remainderDebt,
      this.fullAdress});

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
      link: json['Номер'],
      regNumberIP: json['РегНомерИП'],
      sumDebt: json['ОбщаяСуммаДолга'],
      remainderDebt: json['ОстатокДолга'],
      fullAdress: json['ФондСПрРодитель'] +" "+ json['ФондСПр']+" "+ json['КвартираФонда']
      
    );
  }
}
