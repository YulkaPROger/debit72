class SetlementAccounts {
  var number;
  String bank;
  String accountType;

  SetlementAccounts({this.number, this.bank, this.accountType});

    factory SetlementAccounts.fromJson(Map<String, dynamic> json) {
    return SetlementAccounts(
      number: json['НомерСчета'],
      bank: json['Банк'],
      accountType: json['ВидСчета']
      
    );
  }
}