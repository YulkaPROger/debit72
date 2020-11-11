import 'package:debit72/theme/settings.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class JOWList extends StatefulWidget {
  @override
  _JOWListState createState() => _JOWListState();
}

class _JOWListState extends State<JOWList> {
  @override
  void initState() {
    super.initState();
    final InitialCubit jowCubit = context.bloc<InitialCubit>();
    jowCubit.fetchJOWsFromJSON();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialJOW) {
          return Center(
            child: Text("Данные не загружены"),
          );
        }

        if (state is JOWLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: theme.accentColor,
            ),
          );
        }

        if (state is JOWLoaded) {
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
                            Icon(AntDesign.calendar, color: theme.accentColor),
                            SizedBox(width: 8,),
                            Text(
                              "Дата: ${state.loadedDataInfo[index].date}",
                            ),
                          ],
                        ),
                        Text("Суд: ${state.loadedDataInfo[index].courtCode}"),
                        state.loadedDataInfo[index].court ==
                                state.loadedDataInfo[index].hearingCourt
                            ? Container()
                            : Text(
                                "Суд, рассматривающий заявление: ${state.loadedDataInfo[index].hearingCourtCode}"),
                        Text(
                            "${state.loadedDataInfo[index].claimant}"),
                        Text(
                            "Должник(и): \n${state.loadedDataInfo[index].defendants}"),
                        Text(
                            "Ул. ${state.loadedDataInfo[index].street}, д. ${state.loadedDataInfo[index].house} кв. ${state.loadedDataInfo[index].apartment}"),
                      ],
                    ),
                  );
                }),
          );
        }

        if (state is JOWError) {
          return Center(
            child: Text("Error fetching JOW"),
          );
        }
        return null;
      },
    );
  }
}
