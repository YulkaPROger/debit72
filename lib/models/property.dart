class Property {
  String propertyClaimant;
  bool arrested;
  String dateInventaryArested;
  String amountInventary;

  Property({this.propertyClaimant, this.arrested, this.dateInventaryArested, this.amountInventary});

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
        propertyClaimant: json['ОбъектыНедвижимостиДолжника'],
        arrested: json['Аретовано'],
        dateInventaryArested: json['ДатаОписиАреста'],
        amountInventary: json['СуммаПоОценке']
        
        );
  }
}
