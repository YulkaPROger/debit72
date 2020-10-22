import '../../cubit/initial/initial_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RowResultsIP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialInitial) {
          return Container();
        }

        if (state is IpLoading) {
          return Container();
        }

        if (state is IpLoaded) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Итого: ",
                ),
                Text(
                  state.loadedData.length.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }

        if (state is IpError) {
          return Container();
        }
        return null;
      },
    );
  }
}
