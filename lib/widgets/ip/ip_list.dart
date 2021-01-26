import 'package:debit72/theme/settings.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../cubit/initial/initial_cubit.dart';
import '../../models/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class IPList extends StatefulWidget {
  @override
  _IPListState createState() => _IPListState();
}

class _IPListState extends State<IPList> {
  @override
  void initState() {
    super.initState();
    final InitialCubit jowCubit = context.bloc<InitialCubit>();
    // jowCubit.fetchIP();
    jowCubit.fetchIPfromJSON();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    ProviderModel provider = Provider.of(context);
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialInitial) {
          return Center(
            child: Text('''If you see this message, then you need to follow these steps:
Step # 1 - return to the home screen and swipe to the right
Step # 2 - in the input field at the top of the screen, replace the text API key not found with the text - test
Step 3 - press the save button
Step # 4 - restart the application.
Step # 5 - click the refresh button at the bottom of this screen'''),
          
          );
        }

        if (state is IpLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: theme.accentColor,
            ),
            //child: CircularProgressIndicator(),
          );
        }

        if (state is IpLoaded) {
          return Container(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                itemCount: state.loadedData.length,
                itemBuilder: (context, index) {
                  return NeumorphicButton(
                    margin: EdgeInsets.all(8),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        lightSource: Provider.of<Settings>(context).isDarkMode
                            ? LightSource.bottomRight
                            : LightSource.topLeft,
                        depth: 2,
                        color: theme.buttonColor),
                    onPressed: () {
                      var id = state.loadedData[index].link.toString();
                      provider.setNumID(numForSetNumID: id);
                      print(state.loadedData[index].link);
                      Navigator.of(context).pushNamed('ipDetail');
                    },
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Entypo.user,
                              color: theme.accentColor,
                            ),
                            Expanded(child: Text("${state.loadedData[index].defendants}")),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "Ул. ${state.loadedData[index].street}, д. ${state.loadedData[index].house} кв. ${state.loadedData[index].apartment}"),
                            ),
                            Icon(
                              Entypo.home,
                              color: theme.accentColor,
                            ),
                          ],
                        ),
                        Divider(
                          color: theme.accentColor,
                        ),
                        Text("${state.loadedData[index].claimant}"),
                        Text(
                          "ИД: ${state.loadedData[index].numberID}",
                        ),
                        Text(
                          "ИП: ${state.loadedData[index].regNumberIP}",
                        ),
                        Text(
                          "${state.loadedData[index].bailiffDepartment}",
                        ),
                        Row(
                          children: [
                            Icon(
                              Entypo.medal,
                              color: theme.accentColor,
                            ),
                            Expanded(
                              child: Text(
                                "${state.loadedData[index].bailiff}",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: theme.accentColor,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Долг: ${state.loadedData[index].sumDebt} руб.",
                                ),
                                Text(
                                  "Остаток: ${state.loadedData[index].remainderDebt} руб.",
                                ),
                                // PersentIndicator(
                                //   percent: double.parse(state
                                //           .loadedData[index].remainderDebt)??0.01 /
                                //       double.parse(
                                //           state.loadedData[index].sumDebt)??0.01,
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        }

        if (state is IpError) {
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
}
