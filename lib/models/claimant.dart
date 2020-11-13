class Claimant {
  String name;
  String adress;
  String bank;
  String inn;
  String kpp;
  String ogrn;
  String rs;
  String ks;
  String fullName;
  String shef;
  String phone;
  String email;


  Claimant(
      {this.name,
      this.adress,
      this.bank,
      this.inn,
      this.kpp,
      this.ogrn,
      this.rs,
      this.ks,
      this.fullName,
      this.shef,
      this.phone,
      this.email});

  factory Claimant.fromJson(Map<String, dynamic> json) {
    return Claimant(
      name: json['Наименование'],
      adress: json['Адрес'],
      bank: json['Банк'],
      inn: json['ИНН'],
      kpp: json['КПП'],
      ogrn: json['ОГРН'],
      rs: json['РС'],
      ks: json['КС'],
      fullName: json['ПолноеНаименование'],
      shef: json['Директор'],
      phone: json['Телефон'],
      email: json['EMail']
      
    );
  }
}