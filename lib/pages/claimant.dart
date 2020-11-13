import 'package:debit72/widgets/claimant/claimant_list.dart';

import '../cubit/initial/initial_cubit.dart';
import '../services/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Claimant extends StatefulWidget {
  @override
  _ClaimantState createState() => _ClaimantState();
}

class _ClaimantState extends State<Claimant> {
  final RepositoryIP repository = RepositoryIP();
  
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // final GlobalKey<ScaffoldState> _scaffoldKeyAvto =
    //     GlobalKey<ScaffoldState>();

    return BlocProvider<InitialCubit>(
      create: (context) => InitialCubit(repository: repository),
      child: Scaffold(
        // key: _scaffoldKeyAvto,
        appBar: AppBar(
          backgroundColor: theme.buttonColor,
          iconTheme: IconThemeData(
            color: theme.accentColor,
          ),
          title: Text("Взыскатели"),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(child: ClaimantList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
