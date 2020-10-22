class AvtoIPList {
  String numberIP;
  String regNumberIP;
  String amountDebt;
  String remainingDebt;
  String codesVKSP;
  String spi;
  String claimant;
  String apartment;
  String house;
  String street;

  AvtoIPList(
      {this.numberIP,
      this.regNumberIP,
      this.amountDebt,
      this.remainingDebt,
      this.codesVKSP,
      this.spi,
      this.claimant,
      this.apartment,
      this.house,
      this.street});

  factory AvtoIPList.fromJson(Map<String, dynamic> jsonMap) {
    return AvtoIPList(
        numberIP: jsonMap['Номер'],
        regNumberIP: jsonMap['РегНомерИП'],
        amountDebt: jsonMap['ОбщаяСуммаДолга'],
        remainingDebt: jsonMap['ОстатокДолга'],
        codesVKSP: jsonMap['КодыВКСП'],
        spi: jsonMap['СПИ'],
        claimant: jsonMap['Взыскатель'],
        apartment: jsonMap['КвартираФонда'],
        house: jsonMap['КвартираФондаВладелец'],
        street: jsonMap['КвартираФондаВладелецРодитель']);
  }
}
