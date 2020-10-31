import '../../cubit/initial/initial_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RowResultsIP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialInitial) {
          return Container();
        }

        if (state is IpLoading) {
          return Container();
        }

        if (state is IpLoaded) {
          return RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'ip');
            },
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Итого: ",
                  style: TextStyle(fontWeight: FontWeight.bold, color: theme.accentColor)
                ),
                Text(
                  state.loadedData.length.toString(),
                  
                  style: TextStyle(fontWeight: FontWeight.bold, color: theme.accentColor),
                ),
              ],
            ),
          );
          // return Container(
          //   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          //   padding: const EdgeInsets.all(6.0),
          //   child: RaisedButton(
          //                 child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Text(
          //           "Итого: ",
          //         ),
          //         Text(
          //           state.loadedData.length.toString(),
          //           style: TextStyle(fontWeight: FontWeight.bold),
          //         ),
          //       ],
          //     ),
          //   ),
          // );
        }

        if (state is IpError) {
          return Container();
        }
        return null;
      },
    );
  }
}
