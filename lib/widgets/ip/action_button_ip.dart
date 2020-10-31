import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ActionButtonIP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InitialCubit ipCubit = context.bloc<InitialCubit>();
    var theme = Theme.of(context);
    return RaisedButton(
        child: Icon(
          AntDesign.retweet,
          size: 30,
          color: theme.accentColor,
        ),
        onPressed: () {
          ipCubit.fetchIP();
        });
  }
}
