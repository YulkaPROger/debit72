import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitialCubit, InitialState>(builder: (context, state) {
      if (state is InitialIpDetail) {
        return Center(
          child: Text("data not loaded"),
        );
      }
      if (state is IpDetailLoading) {
        return Center(
          child: SpinKitFadingCircle(color: Colors.amber),
          //child: CircularProgressIndicator(),
        );
      }

      if (state is IpDetailLoaded) {
        var ip = state.loadedDataIP[0];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Номер дела - ${ip.lineNumberOfTabExcel}"),
            Text(
              "Фонд: ул. ${ip.street}, д. ${ip.house}, кв. ${ip.apartment}",
              style: TextStyle(fontSize: 14),
            ),
          ],
        );
      }
      if (state is IpDetailError) {
        return Center(
          child: Text("Error fetching IP"),
        );
      }
      return Container();
    });
    // return Text("ИП №: ${provider.numID}");
  }
}
