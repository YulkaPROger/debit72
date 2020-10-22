import '../cubit/initial/initial_cubit.dart';
import '../pages/nav_bar.dart';
import '../services/repo.dart';
import '../widgets/ip/action_button_ip.dart';
import '../widgets/ip/ip_list.dart';
import '../widgets/ip/row_results_ip.dart';
import '../widgets/ip/search_field_ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IPScreen extends StatefulWidget {
  @override
  _IPScreenState createState() => _IPScreenState();
}

class _IPScreenState extends State<IPScreen> {
  final RepositoryIP repository = RepositoryIP();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider<InitialCubit>(
      create: (context) => InitialCubit(repository: repository),
      child: Scaffold(
        appBar: AppBar(
          title: SearchFieldIP(),
        ),
        key: _scaffoldKey,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RowResultsIP(),
            ActionButtonIP(),
          ],
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(child: IPList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
