class Employer {
  String employerName;
  String employerAdres;
  String dateRelevanceInfo;
  String foreclosure;
  String dateForeclosure;
  String shpi;

  Employer({this.employerName, this.employerAdres, this.dateRelevanceInfo, this.foreclosure, this.dateForeclosure, this.shpi});

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      employerName: json['Работодатель'],
      employerAdres: json['АдресРаботодателя'],
      dateRelevanceInfo: json['ДатаАктуальностиСведений'],
      foreclosure: json['ОбращениеВзыскания'],
      dateForeclosure: json['ДатаОбращенияВзыскания'],
      shpi: json['ШПИ']
      
    );
  }
}