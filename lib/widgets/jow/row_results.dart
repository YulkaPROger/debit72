import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RowResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialJOW) {
          return Container();
        }

        if (state is JOWLoading) {
          return Container();
        }

        if (state is JOWLoaded) {
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
                  state.loadedDataInfo.length.toString(),
                  
                  style: TextStyle(fontWeight: FontWeight.bold, color: theme.accentColor),
                ),
              ],
            ),
          );
          // return Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text(
          //       "Итого: ",
          //     ),
          //     Text(
          //       state.loadedDataInfo.length.toString(),
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // );
        }

        if (state is JOWError) {
          return Container();
        }
        return null;
      },
    );
  }
}
