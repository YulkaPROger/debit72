import 'package:debit72/models/previous_info.dart';
import 'package:debit72/services/category.dart';
import 'package:debit72/widgets/home/pie_chart.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class PreviousInfo extends StatefulWidget {
  const PreviousInfo({
    Key key,
  }) : super(key: key);

  @override
  _PreviousInfoState createState() => _PreviousInfoState();
}

class _PreviousInfoState extends State<PreviousInfo> {
  @override
  void initState() {
    super.initState();
    final InitialCubit jowCubit = context.bloc<InitialCubit>();

    jowCubit.fetchPreviousInfo();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialInfo) {
          return Center(
            child: Text("data not loaded"),
          );
        }

        if (state is InfoLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: theme.accentColor,
            ),
          );
        }

        if (state is InfoLoaded) {
          var info = state.loadedDataInfo[0];
          final kCategories = [
            Category('Общая сумма долгов', amount: info.totalAmountDebt),
            Category('Остаток долгов', amount: info.remainingDebt),
            Category('Сумма пошлин', amount: info.dutyAmount),
            Category('Сумма юр услуг', amount: info.sumOfYurServices),
            Category('Сумма пени', amount: info.penaltyAmount),
            Category('Сумма ЖКУ', amount: info.amountOfCollectingZhKU),
          ];
          return Row(
            children: [
              Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Text(
                        "ОБЩАЯ СВОДКА",
                        style: TextStyle(fontSize: 12),
                      ),
                      Points(
                        text:
                            "Общая сумма долгов: \n${numFormat(info.totalAmountDebt)}",
                        color: Colors.redAccent,
                      ),
                      Points(
                        text:
                            "Остаток долгов: \n${numFormat(info.remainingDebt)}",
                        color: Colors.orangeAccent,
                      ),
                      Points(
                        text: "Сумма пошлин: \n${numFormat(info.dutyAmount)}",
                        color: Colors.yellowAccent,
                      ),
                      Points(
                        text:
                            "Сумма юр услуг: \n${numFormat(info.sumOfYurServices)}",
                        color: Colors.greenAccent,
                      ),
                      Points(
                        text: "Сумма пени: \n${numFormat(info.penaltyAmount)}",
                        color: Colors.blueAccent,
                      ),
                      Points(
                        text:
                            "Сумма ЖКУ: \n${numFormat(info.amountOfCollectingZhKU)}",
                        color: Colors.purpleAccent,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LayoutBuilder(builder: (context, constraint) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              color: theme.buttonColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: -10,
                                    blurRadius: 10,
                                    offset: Offset(-5, -5),
                                    color: Colors.white),
                                BoxShadow(
                                    spreadRadius: -2,
                                    blurRadius: 10,
                                    offset: Offset(7, 7),
                                    color: Colors.black54),
                              ]),
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 80,
                                  child: CustomPaint(
                                    child: Center(),
                                    foregroundPainter: PieChart(
                                        width: 80, categories: kCategories),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: theme.buttonColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1,
                                        offset: Offset(-1, -1),
                                        color: Colors.white,
                                      ),
                                      BoxShadow(
                                        spreadRadius: -2,
                                        blurRadius: 10,
                                        offset: Offset(5, 5),
                                        color: Colors.black.withOpacity(0.5),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text('${info.quantity}'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  )),
            ],
          );
        }

        if (state is InfoError) {
          return Center(
            child: Text("Ошибка получения данных"),
          );
        }
        return Container();
      },
    );
  }
}

class Points extends StatelessWidget {
  const Points({
    Key key,
    this.color,
    this.text,
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(
          width: 10,
        ),
        Text(text)
      ],
    );
  }
}

numFormat(infoDebt) {
  return NumberFormat.currency(locale: 'ru').format(infoDebt);
}
