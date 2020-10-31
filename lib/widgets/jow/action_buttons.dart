import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final InitialCubit ipCubit = context.bloc<InitialCubit>();
    return RaisedButton(
        child: Icon(
          AntDesign.retweet,
          size: 30,
          color: theme.accentColor,
        ),
        onPressed: () {
          ipCubit.fetchJOWs();
        });
  }
}
