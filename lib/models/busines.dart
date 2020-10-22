class Busines {
  String propertyBusines;
  String adresBusines;
  int inn;
  int ogrn;
  var valueShare;
  String sizeShare;
  Busines(
      {this.propertyBusines,
      this.adresBusines,
      this.inn,
      this.ogrn,
      this.valueShare,
      this.sizeShare});

  factory Busines.fromJson(Map<String, dynamic> json) {
    return Busines(
        propertyBusines: json['ИмуществоЕГРЮЛ'],
        adresBusines: json['АдресЮЛ'],
        inn: json['ИНН'],
        ogrn: json['ОГРН'],
        valueShare: json['СтоимостьДоли'],
        sizeShare: json['РазмерДоли']);
  }
}
