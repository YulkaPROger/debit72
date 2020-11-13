import 'package:debit72/theme/settings.dart';
import 'package:debit72/widgets/avto_list/countdown_painter.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../cubit/initial/initial_cubit.dart';
import '../../models/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class AvtoList extends StatefulWidget {
  @override
  _AvtoListState createState() => _AvtoListState();
}

class _AvtoListState extends State<AvtoList> {
  @override
  void initState() {
    super.initState();
    final InitialCubit jowCubit = context.bloc<InitialCubit>();
    jowCubit.fetchAvtoListFromJSON();
  }

  @override
  Widget build(BuildContext context) {



    var theme = Theme.of(context);
    ProviderModel provider = Provider.of(context);
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialAvto) {
          return Center(
            child: Text("Данные не загружены"),
          );
        }

        if (state is AvtoLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: theme.accentColor,
            ),
            //child: CircularProgressIndicator(),
          );
        }

        if (state is AvtoLoaded) {

          return Container(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                itemCount: state.loadedDataInfo.length,
                itemBuilder: (context, index) {
                  return Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        lightSource: Provider.of<Settings>(context).isDarkMode
                            ? LightSource.bottomRight
                            : LightSource.topLeft,
                        depth: 2,
                        color: theme.buttonColor),
                    margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Ionicons.ios_car,
                              color: theme.accentColor,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Text(
                                  "Модель: ${state.loadedDataInfo[index].modelTS}\nГос номер: ${state.loadedDataInfo[index].numberTS}"),
                              // Text(
                              //     "${state.loadedDataInfo[index].debitorVehicles}"),
                            ),
                          ],
                        ),
                        state.loadedDataInfo[index].ammountTS != ""
                            ? Row(
                                children: [
                                  Icon(
                                    Foundation.dollar_bill,
                                    color: theme.accentColor,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${state.loadedDataInfo[index].ammountTS}",
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        Divider(
                          color: theme.accentColor,
                        ),
                        
                        Row(
                          children: [
                            Icon(
                              Entypo.user,
                              color: theme.accentColor,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Text(
                                "${state.loadedDataInfo[index].debitor}",
                              ),
                            ),
                          ],
                        ),
                        state.loadedDataInfo[index].apartment == " "
                            ? Text(
                                "Ул. ${state.loadedDataInfo[index].street}, д. ${state.loadedDataInfo[index].house} кв. ${state.loadedDataInfo[index].apartment}")
                            : Container(),
                        state.loadedDataInfo[index].arestoredTS != "Нет"
                            ? Text(
                                "ТС арестовано: ${state.loadedDataInfo[index].arestoredTS}, Дата ареста ТС: ${state.loadedDataInfo[index].dateOfArrest}, Статус реализации: ${state.loadedDataInfo[index].salesStatus}, ТС реализовано: ${state.loadedDataInfo[index].tsRealized}",
                              )
                            : Container(),
                        state.loadedDataInfo[index].commentCar != ""
                            ? Text(
                                "Комментарий: ${state.loadedDataInfo[index].commentCar}",
                              )
                            : Container(),
                        state.loadedDataInfo[index].ipArested != ""
                            ? Text(
                                "ИП, по которому арестовано ТС: ${state.loadedDataInfo[index].ipArested}",
                              )
                            : Container(),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 160,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  state.loadedDataInfo[index].ipList.length,
                              itemBuilder: (context, i) {
                                var ip = state.loadedDataInfo[index].ipList[i];
                                return Stack(children: [
                                  Container(
                                    width: 230,
                                    child: NeumorphicButton(
                                      margin:
                                          EdgeInsets.only(right: 8, bottom: 8),
                                      padding: EdgeInsets.only(left: 16),
                                      style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          lightSource:
                                              Provider.of<Settings>(context)
                                                      .isDarkMode
                                                  ? LightSource.bottomRight
                                                  : LightSource.topLeft,
                                          depth: 2,
                                          color: theme.buttonColor),
                                      onPressed: () {
                                        var ipDetail = ip.numberIP.toString();
                                        provider.setNumID(
                                            numForSetNumID: ipDetail);
                                        print(ipDetail);
                                        Navigator.of(context)
                                            .pushNamed('ipDetail');
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${ip.regNumberIP}"),
                                          Text("${ip.claimant}"),
                                          Text(
                                              "Ул. ${ip.street}, д. ${ip.house} кв. ${ip.apartment}"),
                                          Text(
                                            "Долг: ${ip.amountDebt}",
                                          ),
                                          Text(
                                            "Остаток: ${ip.remainingDebt}",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 152,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        color: theme.accentColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8))),
                                  ),
                                  Positioned(
                                    bottom: 10.0,
                                    right: 5.0,
                                    child: CustomPaint(
                                      foregroundPainter: CountdownPainter(
                                        bgColor: Colors.transparent,
                                        lineColor: (double.parse(ip.remainingDebt)/double.parse(ip.amountDebt))<0?Colors.redAccent:theme.accentColor,
                                        percent: double.parse(ip.remainingDebt)/double.parse(ip.amountDebt),
                                        width: 4.0,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              _getPersent(ip.remainingDebt, ip.amountDebt),
                                              style: TextStyle(
                                                color: (double.parse(ip.remainingDebt)/double.parse(ip.amountDebt))<0?Colors.redAccent:theme.accentColor,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "остаток",
                                              style: TextStyle(
                                                color: (double.parse(ip.remainingDebt)/double.parse(ip.amountDebt))<0?Colors.redAccent:theme.accentColor,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]);
                              }),
                        ),
                      ],
                    ),
                  );
                }),
          );
        }

        if (state is AvtoError) {
          return Center(
            child: Text("Error fetching IP"),
          );
        }
        return null;
      },
    );
  }
    _getPersent(String num1, String num2) {
    
      double num3 = double.parse(num1)/double.parse(num2);
      var num4 = double.parse(num3.toString()).toStringAsFixed(2);
      var num5 = double.parse(num4)*100;
      var num6 = double.parse(num5.toString()).toStringAsFixed(0);

    return (num6).toString() + "%";
  }
}
