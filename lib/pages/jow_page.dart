import '../cubit/initial/initial_cubit.dart';
import '../pages/nav_bar.dart';
import '../services/repo.dart';
import '../widgets/jow/action_buttons.dart';
import '../widgets/jow/jow_list.dart';
import '../widgets/jow/row_results.dart';
import '../widgets/jow/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyJOW extends StatefulWidget {
  @override
  _MyJOWState createState() => _MyJOWState();
}

class _MyJOWState extends State<MyJOW> {
  final RepositoryIP repository = RepositoryIP();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider<InitialCubit>(
      create: (context) => InitialCubit(repository: repository),
      child: Scaffold(
        appBar: AppBar(
          title: SearchField(),
        ),
        key: _scaffoldKey,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RowResults(),
            ActionButton(),
          ],
        ),
        body: SafeArea(
          child: Container(
            child: Column(children: [
              Expanded(child: JOWList()),
            ]),
          ),
        ),
      ),
    );
  }
}
