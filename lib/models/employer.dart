class Employer {
  String employerName;
  String employerAdres;
  String dateRelevanceInfo;

  Employer({this.employerName, this.employerAdres, this.dateRelevanceInfo});

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      employerName: json['Работодатель'],
      employerAdres: json['АдресРаботодателя'],
      dateRelevanceInfo: json['ДатаАктуальностиСведений']
      
    );
  }
}