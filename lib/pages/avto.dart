import '../cubit/initial/initial_cubit.dart';
import '../services/repo.dart';
import '../widgets/avto_list/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../widgets/avto_list/action_button_avto.dart';
import '../widgets/avto_list/avto_list.dart';
import '../widgets/avto_list/result.dart';

class Avto extends StatefulWidget {
  @override
  _AvtoState createState() => _AvtoState();
}

class _AvtoState extends State<Avto> {
  final RepositoryIP repository = RepositoryIP();
  
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final GlobalKey<ScaffoldState> _scaffoldKeyAvto =
        GlobalKey<ScaffoldState>();

    return BlocProvider<InitialCubit>(
      create: (context) => InitialCubit(repository: repository),
      child: Scaffold(
        key: _scaffoldKeyAvto,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: theme.accentColor,
          ),
          title: SearchFieldAvto(),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RowResultsAvto(),
            ActionButtonAvto(),
          ],
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(child: AvtoList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
