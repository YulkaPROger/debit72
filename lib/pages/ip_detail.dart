import '../cubit/initial/initial_cubit.dart';
import '../models/provider.dart';
import '../services/repo.dart';
import '../widgets/ip_detail/app_bar_text.dart';
import '../widgets/ip_detail/ip_detail_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class IPDetail extends StatefulWidget {
  @override
  _IPDetailState createState() => _IPDetailState();
}

class _IPDetailState extends State<IPDetail> {
  final RepositoryIP repository = RepositoryIP();

  @override
  Widget build(BuildContext context) {
    ProviderModel provider = Provider.of(context);
    return BlocProvider<InitialCubit>(
      create: (context) => InitialCubit(repository: repository),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarText(),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: IPListDetail(
                    id: provider.numID,
                  ),
                )
              ],
            ),
          ),
        ),
        // body: SingleChildScrollView(
        //   child: IPListDetail(
        //     id: provider.numID,
        //   ),
        // ),
      ),
    );
  }
}
