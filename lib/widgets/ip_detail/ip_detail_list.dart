import 'package:debit72/theme/settings.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
            child: Text("data not loaded"),
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
                            ],
                          ),
                          leading: Icon(
                            Icons.person,
                            color: theme.accentColor,
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                "Пенсионер:",
                              ),
                              Icon(
                                ip.debitorPensioner != "Нет"
                                    ? Icons.check_circle
                                    : Icons.close,
                                color: ip.debitorPensioner != "Нет"
                                    ? Colors.teal
                                    : Colors.redAccent[400],
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: ip.avto.length > 0 ? 150 : 0,
                            child: ip.avto.length > 0
                                ? ListView.builder(
                                    itemCount: ip.avto.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Neumorphic(
                                        style: NeumorphicStyle(
                                            shape: NeumorphicShape.concave,
                                            lightSource:
                                                Provider.of<Settings>(context)
                                                        .isDarkMode
                                                    ? LightSource.bottomRight
                                                    : LightSource.topLeft,
                                            depth: 2,
                                            color: theme.buttonColor),
                                        margin: const EdgeInsets.all(8),
                                        child: Container(
                                          width: 300,
                                          child: ListTile(
                                            leading: Icon(Ionicons.ios_car,
                                                color: theme.accentColor),
                                            title: Text(
                                              "${ip.avto[index].avto}",
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Модель: ${ip.avto[index].model}",
                                                ),
                                                Text(
                                                  "Гос. номер: ${ip.avto[index].stateNumber}",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Container()),
                        Container(
                            height: ip.setlementsAccounts.length > 0 ? 100 : 0,
                            child: ip.setlementsAccounts.length > 0
                                ? ListView.builder(
                                    itemCount: ip.setlementsAccounts.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.all(8),
                                        child: Neumorphic(
                                          style: NeumorphicStyle(
                                              shape: NeumorphicShape.concave,
                                              lightSource:
                                                  Provider.of<Settings>(context)
                                                          .isDarkMode
                                                      ? LightSource.bottomRight
                                                      : LightSource.topLeft,
                                              depth: 2,
                                              color: theme.buttonColor),
                                          child: Container(
                                            width: 300,
                                            child: ListTile(
                                              leading: Icon(Entypo.credit_card,
                                                  color: theme.accentColor),
                                              title: Text(
                                                "${ip.setlementsAccounts[index].number}",
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    "Тип счета: ${ip.setlementsAccounts[index].accountType}",
                                                  ),
                                                  Text(
                                                    "БАНК: ${ip.setlementsAccounts[index].bank}",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Container()),
                        Container(
                            height: ip.property.length > 0 ? 250 : 0,
                            child: ip.property.length > 0
                                ? ListView.builder(
                                    itemCount: ip.property.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Neumorphic(
                                        style: NeumorphicStyle(
                                            shape: NeumorphicShape.concave,
                                            lightSource:
                                                Provider.of<Settings>(context)
                                                        .isDarkMode
                                                    ? LightSource.bottomRight
                                                    : LightSource.topLeft,
                                            depth: 2,
                                            color: theme.buttonColor),
                                        margin: const EdgeInsets.all(8),
                                        child: Container(
                                          width: 300,
                                          child: ListTile(
                                            leading: Icon(
                                              Ionicons.ios_home,
                                              color: theme.accentColor,
                                            ),
                                            title: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${ip.property[index].propertyClaimant}",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Container()),
                        Container(
                            height: ip.busines.length > 0 ? 300 : 0,
                            child: ip.busines.length > 0
                                ? ListView.builder(
                                    itemCount: ip.busines.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Neumorphic(
                                        style: NeumorphicStyle(
                                            shape: NeumorphicShape.concave,
                                            lightSource:
                                                Provider.of<Settings>(context)
                                                        .isDarkMode
                                                    ? LightSource.bottomRight
                                                    : LightSource.topLeft,
                                            depth: 2,
                                            color: theme.buttonColor),
                                        margin: const EdgeInsets.all(8),
                                        child: Container(
                                          width: 300,
                                          child: ListTile(
                                            leading: Icon(
                                              Ionicons.ios_business,
                                              color: theme.accentColor,
                                            ),
                                            title: Text(
                                              "Наименование: ${ip.busines[index].propertyBusines}",
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  "Адрес: ${ip.busines[index].adresBusines}",
                                                ),
                                                Text(
                                                  "ИНН: ${ip.busines[index].inn}",
                                                ),
                                                Text(
                                                  "ОГРН: ${ip.busines[index].ogrn}",
                                                ),
                                                Text(
                                                  "Размер доли: ${ip.busines[index].sizeShare}",
                                                ),
                                                Text(
                                                  "Стоимость доли: ${ip.busines[index].valueShare}",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Container()),
                        Container(
                            height: ip.employer.length > 0 ? 200 : 0,
                            child: ip.employer.length > 0
                                ? ListView.builder(
                                    itemCount: ip.employer.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Neumorphic(
                                        style: NeumorphicStyle(
                                            shape: NeumorphicShape.concave,
                                            lightSource:
                                                Provider.of<Settings>(context)
                                                        .isDarkMode
                                                    ? LightSource.bottomRight
                                                    : LightSource.topLeft,
                                            depth: 2,
                                            color: theme.buttonColor),
                                        margin: const EdgeInsets.all(8),
                                        child: Container(
                                          width: 300,
                                          child: ListTile(
                                            leading: Icon(MaterialIcons.work,
                                                color: theme.accentColor),
                                            title: Text(
                                              "Наименование: ${ip.employer[index].employerName}",
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Адрес: ${ip.employer[index].employerAdres}",
                                                ),
                                                Text(
                                                  "Дата актуальности: ${ip.employer[index].dateRelevanceInfo}",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Container()),
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
            child: Text("Error fetching IP"),
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

class PersentIndicator extends StatelessWidget {
  final double percent;
  const PersentIndicator({
    Key key,
    this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0, right: 8.0),
      child: NeumorphicProgress(
        duration: Duration(microseconds: 1500),
        height: 12,
        style: ProgressStyle(
            depth: -2,
            accent: percent < 0 ? Colors.red : theme.accentColor,
            variant: percent < 0 ? Colors.red : theme.indicatorColor),
        percent: percent < 0 ? percent * (-1) : percent,
      ),
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
