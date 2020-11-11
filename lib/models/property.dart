class Property {
  String propertyClaimant;
  String arrested;
  Property({this.propertyClaimant, this.arrested});

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
        propertyClaimant: json['ОбъектыНедвижимостиДолжника'],
        arrested: json['Аретовано']);
  }
}
