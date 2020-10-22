class Property {
  String propertyClaimant;
  Property({this.propertyClaimant});

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(propertyClaimant: json['ОбъектыНедвижимостиДолжника']);
  }
}
