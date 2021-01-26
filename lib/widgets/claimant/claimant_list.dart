import 'package:debit72/theme/settings.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sms/flutter_sms.dart';

class ClaimantList extends StatefulWidget {
  @override
  _ClaimantListState createState() => _ClaimantListState();
}

class _ClaimantListState extends State<ClaimantList> {
  @override
  void initState() {
    super.initState();
    final InitialCubit jowCubit = context.bloc<InitialCubit>();
    jowCubit.fetchClaimants();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialClaimant) {
          return Center(
            child: Text('''If you see this message, then you need to follow these steps:
Step # 1 - return to the home screen and swipe to the right
Step # 2 - in the input field at the top of the screen, replace the text API key not found with the text - test
Step 3 - press the save button
Step # 4 - restart the application.
Step # 5 - click the refresh button at the bottom of this screen'''),
          
          );
        }

        if (state is LoadingClaimant) {
          return Center(
            child: SpinKitFadingCircle(
              color: theme.accentColor,
            ),
          );
        }

        if (state is LoadedClaimant) {
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
                    margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${state.loadedDataInfo[index].name}",
                                style: TextStyle(
                                    color: theme.accentColor, fontSize: 16),
                              ),
                            ),
                            IconButton(
                              icon: Icon(EvilIcons.share_apple),
                              iconSize: 30,
                              onPressed: () async {
                                print("tap");
                                String message = "Наименование ${state.loadedDataInfo[index].fullName},\nДиректор ${state.loadedDataInfo[index].shef},\nТелефон: ${state.loadedDataInfo[index].phone},\nE-mail: ${state.loadedDataInfo[index].email},\nАдрес ${state.loadedDataInfo[index].adress},\nБанк: ${state.loadedDataInfo[index].bank},\nИНН: ${state.loadedDataInfo[index].inn},\nКПП: ${state.loadedDataInfo[index].kpp},\nРС: ${state.loadedDataInfo[index].rs},\nКС: ${state.loadedDataInfo[index].ks},\n";
                                List<String> recipents = [
                                  ""
                                ];

                                _sendSMS(message, recipents);
                              },
                              padding: EdgeInsets.all(0),
                            ),
                          ],
                        ),
                        Divider(color: theme.accentColor),
                        Text(
                            "Полное наименование:\n${state.loadedDataInfo[index].fullName}"),
                        Text("Директор: ${state.loadedDataInfo[index].shef}"),
                        Text("Телефон: ${state.loadedDataInfo[index].phone}"),
                        Text("E-mail: ${state.loadedDataInfo[index].email}"),
                        Text("${state.loadedDataInfo[index].adress}"),
                        Divider(color: theme.accentColor),
                        Text("Банк: ${state.loadedDataInfo[index].bank}"),
                        Text("ИНН: ${state.loadedDataInfo[index].inn}"),
                        Text("КПП: ${state.loadedDataInfo[index].kpp}"),
                        Text("РС: ${state.loadedDataInfo[index].rs}"),
                        Text("КС: ${state.loadedDataInfo[index].ks}"),
                      ],
                    ),
                  );
                }),
          );
        }

        if (state is ErrorClaimant) {
          return Center(
            child: Text('''If you see this message, then you need to follow these steps:
Step # 1 - return to the home screen and swipe to the right
Step # 2 - in the input field at the top of the screen, replace the text API key not found with the text - test
Step 3 - press the save button
Step # 4 - restart the application.
Step # 5 - click the refresh button at the bottom of this screen'''),
          );
          
        }
        return null;
      },
    );
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
}
