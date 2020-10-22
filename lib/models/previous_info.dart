class Info {
  double quantity;
  double remainingDebt;
  double totalAmountDebt;
  double dutyAmount;
  double sumOfYurServices;
  double penaltyAmount;
  double amountOfCollectingZhKU;
  Info(
      {this.quantity,
      this.remainingDebt,
      this.totalAmountDebt,
      this.dutyAmount,
      this.sumOfYurServices,
      this.penaltyAmount,
      this.amountOfCollectingZhKU});

  factory Info.fromJson(Map<String, dynamic> json) {
    print(json);
    double quantity = double.parse(json['Количество']);
    double remainingDebt = double.parse(json['ОстатокДолга']);
    double totalAmountDebt = double.parse(json['ОбщаяСуммаДолга']);
    double dutyAmount = double.parse(json['СуммаПошлины']);
    double sumOfYurServices = double.parse(json['СуммаЮрУслуг']);
    double penaltyAmount = double.parse(json['СуммаПени']);
    double amountOfCollectingZhKU = double.parse(json['СуммаВзысканияЖКУ']);

    return Info(
        quantity: quantity,
        remainingDebt: remainingDebt,
        totalAmountDebt: totalAmountDebt,
        dutyAmount: dutyAmount,
        sumOfYurServices: sumOfYurServices,
        penaltyAmount: penaltyAmount,
        amountOfCollectingZhKU: amountOfCollectingZhKU);
  }
}

// [
//     {
//         "Количество": 15838,
//         "ОстатокДолга": 283138593.75,
//         "ОбщаяСуммаДолга": 569726024.11,
//         "СуммаПошлины": 9095657.71,
//         "СуммаЮрУслуг": 8616748.25,
//         "СуммаПени": 79574045.81,
//         "СуммаВзысканияЖКУ": 473112256.59
//     }
// ]
