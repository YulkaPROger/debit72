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
              color: Colors.amber,
            ),
          );
        }

        if (state is InfoLoaded) {
          var info = state.loadedDataInfo[0];
          return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Дел в исполнении: ${info.quantity}",
                          style: TextStyle(fontSize: 12),
                        ),
                        // NeumorphicIndicator(
                        //   orientation:
                        //       NeumorphicIndicatorOrientation.horizontal,
                        //   height: 10,
                        //   width: 20,
                        //   percent: 1,
                        // ),
                        Text(
                          "Общая сумма долгов: ${numFormat(info.totalAmountDebt)}", //NumberFormat.currency(locale: 'eu').format(info.totalAmountDebt)
                          style: TextStyle(fontSize: 12),
                        ),
                        // NeumorphicIndicator(
                        //   orientation:
                        //       NeumorphicIndicatorOrientation.horizontal,
                        //   height: 10,
                        //   width: 20,
                        //   percent: 1,
                        // ),
                        Text(
                          "Остаток долгов: ${numFormat(info.remainingDebt)}", //NumberFormat.currency(locale: 'eu').format(info.totalAmountDebt)
                          style: TextStyle(fontSize: 12),
                        ),
                        // NeumorphicIndicator(
                        //   orientation:
                        //       NeumorphicIndicatorOrientation.horizontal,
                        //   height: 10,
                        //   width: 20,
                        //   percent: info.remainingDebt / info.totalAmountDebt,
                        // ),
                        Text(
                          "Сумма пошлин: ${numFormat(info.dutyAmount)}", //NumberFormat.currency(locale: 'eu').format(info.totalAmountDebt)
                          style: TextStyle(fontSize: 12),
                        ),
                        // NeumorphicIndicator(
                        //   orientation:
                        //       NeumorphicIndicatorOrientation.horizontal,
                        //   height: 10,
                        //   width: 20,
                        //   percent: info.dutyAmount / info.totalAmountDebt,
                        // ),
                        Text(
                          "Сумма юр услуг: ${numFormat(info.sumOfYurServices)}", //NumberFormat.currency(locale: 'eu').format(info.totalAmountDebt)
                          style: TextStyle(fontSize: 12),
                        ),
                        // NeumorphicIndicator(
                        //   orientation:
                        //       NeumorphicIndicatorOrientation.horizontal,
                        //   height: 10,
                        //   width: 20,
                        //   percent: info.sumOfYurServices / info.totalAmountDebt,
                        // ),
                        Text(
                          "Сумма пени: ${numFormat(info.penaltyAmount)}", //NumberFormat.currency(locale: 'eu').format(info.totalAmountDebt)
                          style: TextStyle(fontSize: 12),
                        ),
                        // NeumorphicIndicator(
                        //   orientation:
                        //       NeumorphicIndicatorOrientation.horizontal,
                        //   height: 10,
                        //   width: 20,
                        //   percent: info.penaltyAmount / info.totalAmountDebt,
                        // ),
                        Text(
                          "Сумма взыскания ЖКУ: ${numFormat(info.amountOfCollectingZhKU)}", //NumberFormat.currency(locale: 'eu').format(info.totalAmountDebt)
                          style: TextStyle(fontSize: 12),
                        ),
                        // NeumorphicIndicator(
                        //   orientation:
                        //       NeumorphicIndicatorOrientation.horizontal,
                        //   height: 10,
                        //   width: 20,
                        //   percent: info.amountOfCollectingZhKU /
                        //       info.totalAmountDebt,
                        // ),
                      ]);
        }

        if (state is InfoError) {
          return Center(
            child: Text("Error fetching IP"),
          );
        }
        return Container();
      },
    );
  }
}

numFormat(infoDebt) {
  return NumberFormat.currency(locale: 'ru').format(infoDebt);
}
