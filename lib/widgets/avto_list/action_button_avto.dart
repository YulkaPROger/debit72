import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ActionButtonAvto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InitialCubit ipCubit = context.bloc<InitialCubit>();
    return RaisedButton(
        child: Icon(
          AntDesign.retweet,
          size: 30,
          color: Colors.amber,
        ),
        onPressed: () {
          ipCubit.fetchAvtoList();
        });
  }
}
