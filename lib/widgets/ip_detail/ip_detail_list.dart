import 'package:debit72/models/ip_detail.dart';
import 'package:debit72/theme/settings.dart';
import 'package:debit72/widgets/ip_detail/build_employers.dart';
import 'package:debit72/widgets/ip_detail/build_property.dart';
import 'package:debit72/widgets/ip_detail/build_setlements_account.dart';
import 'package:debit72/widgets/ip_detail/persent_indicator.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'build_avto.dart';
import 'build_business.dart';

class IPListDetail extends StatefulWidget {
  final String id;

  const IPListDetail({Key key, this.id}) : super(key: key);

  @override
  _IPListDetailState createState() => _IPListDetailState();
}

class _IPListDetailState extends State<IPListDetail> {
  @override
  void initState() {
    super.initState();
    final InitialCubit jowCubit = context.bloc<InitialCubit>();

    jowCubit.fetchIPDetail(this.widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialIpDetail) {
          return Center(
            child: Text('''If you see this message, then you need to follow these steps:
Step # 1 - return to the home screen and swipe to the right
Step # 2 - in the input field at the top of the screen, replace the text API key not found with the text - test
Step 3 - press the save button
Step # 4 - restart the application.
Step # 5 - click the refresh button at the bottom of this screen'''),
          
          );
        }

        if (state is IpDetailLoading) {
          return Center(
            child: SpinKitFadingCircle(color: theme.accentColor),
            //child: CircularProgressIndicator(),
          );
        }

        if (state is IpDetailLoaded) {
          var ip = state.loadedDataIP[0];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextOnIndicator(
                    text: "Общая сумма долга: ${ip.totalDebtAmount}",
                  ),
                  PersentIndicator(
                    percent: 1,
                  ),
                  TextOnIndicator(
                    text: "Остаток долга: ${ip.remainingDebt}",
                  ),
                  PersentIndicator(
                    percent: ip.remainingDebt / ip.totalDebtAmount,
                  ),
                  TextOnIndicator(
                    text: "Остаток долга ФССП: ${ip.remainingFSSP}",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Аннулировано:",
                      ),
                      Switch(
                        value: ip.canceled == "Да" ? true : false,
                        onChanged: (bool value) {},
                      ),
                    ],
                  ),
                  ip.canceled == "Да"
                      ? Text(
                          "ПричинаАннуляции: ${ip.reasonForCancellation}",
                        )
                      : Container(),
                  Container(
                    height: 120,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        DateWidget(
                          text1: "Лицевой счет",
                          text2: "",
                          text3: ip.ls,
                        ),
                        DateWidget(
                          text1: "Период с",
                          text2: _dateFromData(ip.periodS),
                          text3: _monthAndYearFromData(ip.periodS),
                        ),
                        DateWidget(
                          text1: "Период до",
                          text2: _dateFromData(ip.periodBefore),
                          text3: _monthAndYearFromData(ip.periodBefore),
                        ),
                        DateWidget(
                          text1: "Дата подачи",
                          text2: _dateFromData(ip.dateOfApplication),
                          text3: _monthAndYearFromData(ip.dateOfApplication),
                        ),
                        DateWidget(
                          text1: "Дата возбуждения",
                          text2: _dateFromData(ip.wakeDate),
                          text3: _monthAndYearFromData(ip.wakeDate),
                        ),
                        DateWidget(
                          text1: "Дата завершения ИП",
                          text2: _dateFromData(ip.completionDateIP),
                          text3: _monthAndYearFromData(ip.completionDateIP),
                        ),
                        InfoWidget(
                          text1: ip.amountSzhku,
                          text2: ip.amountDuty,
                          text3: ip.amountPenalties,
                          text4: ip.amountJudicalServises,
                        )
                        
                      ],
                    ),
                  ),
                  InfoROSP(
                    regNumber: ip.regNumber,
                    productionStatus: ip.productionStatus,
                    codesVKSP: ip.codesVKSP,
                    spi: ip.spi,
                  ),
                  InfoBailief(
                    typeID: ip.typeID,
                    bailiffDepartment: ip.bailiffDepartment,
                    dateID: ip.dateID,
                    numberID: ip.numberID,
                    numberCase: ip.caseNumber,
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Должник: ${ip.debitor}",
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Д.Р.: ${ip.debitorBirthday}",
                              ),
                              Text(
                                "М.Р.: ${ip.debitorBirthplace}",
                              ),
                              Text(
                                "Адрес должника ул. ${ip.debitorStreet}, д. ${ip.debitorHouse}, кв. ${ip.debitorApartment}",
                              ),
                              Text(
                                "Адрес факт: ${ip.adressFact}",
                              ),
                              ip.solidarity != "Нет" ? Text(
                                "Солидарно: ${ip.solidarity}",
                              ):Container(),
                              ip.solidarityFace != null ? Text(
                                "Солидарно с: ${ip.solidarityFace}",
                              ):Container(),
                            ],
                          ),
                          leading: Column(
                            children: [
                              Icon(
                                Icons.person,
                                color: theme.accentColor,
                              ),
                              Icon(
                                ip.dead == "Нет"
                                    ? Icons.check_circle
                                    : Foundation.skull,
                                color: ip.dead == "Нет"
                                    ? theme.accentColor
                                    : Colors.redAccent[400],
                              ),
                              
                            ],
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                "Пенc:",
                              ),
                              Icon(
                                ip.debitorPensioner != "Нет"
                                    ? Icons.check_circle
                                    : Icons.close,
                                color: ip.debitorPensioner != "Нет"
                                    ? theme.accentColor
                                    : Colors.redAccent[400],
                              ),
                              
                            ],
                          ),
                        ),
                        BuildAvtoWidget(ip: ip, theme: theme),
                        BuildSetlementsAccount(ip: ip, theme: theme),
                        BuildProperty(ip: ip, theme: theme),
                        BuildBusines(ip: ip, theme: theme),
                        BuildEmployers(ip: ip, theme: theme),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is IpDetailError) {
          return Center(
            child: Text('''If you see this message, then you need to follow these steps:
Step # 1 - return to the home screen and swipe to the right
Step # 2 - in the input field at the top of the screen, replace the text API key not found with the text - test
Step 3 - press the save button
Step # 4 - restart the application.
Step # 5 - click the refresh button at the bottom of this screen'''),
          
          );
        }
        return Container();
      },
    );
  }
}

class InfoBailief extends StatelessWidget {
  final String typeID;
  final String bailiffDepartment;
  final String dateID;
  final String numberID;
  final String numberCase;
  const InfoBailief({
    Key key,
    this.typeID,
    this.bailiffDepartment,
    this.dateID,
    this.numberID,
    this.numberCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: ListTile(
          leading: Icon(
            Entypo.info,
          ),
          title: Text(
            "ИД: $numberID от $dateID",
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Тип ИД: $typeID",
              ),
              Text(
                "$bailiffDepartment",
              ),
              Text(
                "$numberCase",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoROSP extends StatelessWidget {
  final String regNumber;
  final String productionStatus;
  final String codesVKSP;
  final String spi;
  const InfoROSP({
    Key key,
    this.regNumber,
    this.productionStatus,
    this.codesVKSP,
    this.spi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: ListTile(
          leading: Icon(
            Entypo.info,
          ),
          title: Text(
            "Рег.номер ИП: $regNumber",
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Статус производства: $productionStatus",
              ),
              Text(
                "$codesVKSP",
              ),
              Text(
                "СПИ: $spi",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _dateFromData(String period) {
  if (period != "") {
    return period.substring(0, 2);
  } else
    return "нет";
}

String _monthAndYearFromData(String period) {
  if (period != "") {
    return period.substring(3, period.length);
  } else
    return "данных";
}

class DateWidget extends StatelessWidget {
  final text1;
  final text2;
  final text3;
  final icon;
  const DateWidget({
    Key key,
    this.text1,
    this.text2,
    this.text3,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return NeumorphicButton(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          lightSource: Provider.of<Settings>(context).isDarkMode
              ? LightSource.bottomRight
              : LightSource.topLeft,
          depth: 2,
          color: theme.buttonColor),
      margin: EdgeInsets.only(
        left: 2,
        right: 5,
        top: 5,
        bottom: 5,
      ),
      child: Column(
        children: [
          Text(text1),
          Text(
            text2,
            style: TextStyle(fontSize: 40),
          ),
          Text(
            text3,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
class InfoWidget extends StatelessWidget {
  final text1;
  final text2;
  final text3;
  final text4;
  final icon;
  const InfoWidget({
    Key key,
    this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return NeumorphicButton(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          lightSource: Provider.of<Settings>(context).isDarkMode
              ? LightSource.bottomRight
              : LightSource.topLeft,
          depth: 2,
          color: theme.buttonColor),
      margin: EdgeInsets.only(
        left: 2,
        right: 5,
        top: 5,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Взыскания по ИД"),
          Text("Сумма ЖКУ: $text1"),
          Text(
            "Сумма пошлины: $text2",
          ),
          Text(
            "Сумма пени: $text3"
          ),
          Text(
            "Сумма юр.услуг: $text4"
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}



class TextOnIndicator extends StatelessWidget {
  final text;
  const TextOnIndicator({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
