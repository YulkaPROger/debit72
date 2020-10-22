import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RowResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (context, state) {
        if (state is InitialJOW) {
          return Container();
        }

        if (state is JOWLoading) {
          return Container();
        }

        if (state is JOWLoaded) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Итого: ",
              ),
              Text(
                state.loadedDataInfo.length.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        }

        if (state is JOWError) {
          return Container();
        }
        return null;
      },
    );
  }
}
