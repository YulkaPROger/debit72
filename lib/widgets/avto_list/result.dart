import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RowResultsAvto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialAvto) {
          return Container();
        }

        if (state is AvtoLoading) {
          return Container();
        }

        if (state is AvtoLoaded) {
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
        }

        if (state is AvtoError) {
          return Container();
        }
        return null;
      },
    );
  }
}
