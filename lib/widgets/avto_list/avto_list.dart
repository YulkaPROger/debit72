import 'package:debit72/theme/settings.dart';
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
                        Text(
                            "Авто: ${state.loadedDataInfo[index].debitorVehicles}"),
                        Text(
                            "Модель: ${state.loadedDataInfo[index].modelTS}, Гос номер: ${state.loadedDataInfo[index].numberTS}"),
                        state.loadedDataInfo[index].ammountTS != ""
                            ? Text(
                                "Стоимость ТС: ${state.loadedDataInfo[index].ammountTS}",
                              )
                            : Container(),
                        Text(
                          "Должник: ${state.loadedDataInfo[index].debitor}",
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
                        Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.concave,
                              lightSource:
                                  Provider.of<Settings>(context).isDarkMode
                                      ? LightSource.bottomRight
                                      : LightSource.topLeft,
                              depth: -2,
                              color: theme.buttonColor),
                          child: Container(
                            height: 170,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    state.loadedDataInfo[index].ipList.length,
                                itemBuilder: (context, i) {
                                  var ip =
                                      state.loadedDataInfo[index].ipList[i];
                                  return NeumorphicButton(
                                    margin: EdgeInsets.all(8),
                                    style: NeumorphicStyle(
                                        shape: NeumorphicShape.concave,
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
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${ip.regNumberIP}"),
                                        Text("${ip.claimant}"),
                                        Text("${ip.codesVKSP}"),
                                        Text(
                                            "Ул. ${ip.street}, д. ${ip.house} кв. ${ip.apartment}"),
                                        Text(
                                          "Сумма долга: ${ip.amountDebt}",
                                        ),
                                        Text(
                                          "Остаток долга: ${ip.remainingDebt}",
                                        ),
                                        Text(
                                          "СПИ: ${ip.spi}",
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
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
}
