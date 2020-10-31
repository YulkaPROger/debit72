import 'package:debit72/theme/settings.dart';
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
    jowCubit.fetchIP();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    ProviderModel provider = Provider.of(context);
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialInitial) {
          return Center(
            child: Text("data not loaded"),
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
                        Text(
                          "НомерИД: ${state.loadedData[index].numberID}",
                        ),
                        Text(
                            "НомерДела: \n${state.loadedData[index].caseNumber}"),
                        Text(
                            "Должник: \n${state.loadedData[index].defendants}"),
                        Text(
                            "Взыскатель: \n${state.loadedData[index].claimant}"),
                        Text(
                            "Ул. ${state.loadedData[index].street}, д. ${state.loadedData[index].house} кв. ${state.loadedData[index].apartment}"),
                        Text(
                          "КодыВКСП: ${state.loadedData[index].bailiffDepartment}",
                        ),
                        Text(
                          "СПИ: ${state.loadedData[index].bailiff}",
                        ),
                        Text(
                          "Ccылка: ${state.loadedData[index].link}",
                        ),
                      ],
                    ),
                  );
                }),
          );
        }

        if (state is IpError) {
          return Center(
            child: Text("Error fetching IP"),
          );
        }
        return null;
      },
    );
  }
}
