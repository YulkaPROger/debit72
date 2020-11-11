class Employer {
  String employerName;
  String employerAdres;
  String dateRelevanceInfo;
  String foreclosure;

  Employer({this.employerName, this.employerAdres, this.dateRelevanceInfo, this.foreclosure});

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      employerName: json['Работодатель'],
      employerAdres: json['АдресРаботодателя'],
      dateRelevanceInfo: json['ДатаАктуальностиСведений'],
      foreclosure: json['ОбращениеВзыскания']
      
    );
  }
}