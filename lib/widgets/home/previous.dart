import '../../cubit/initial/initial_cubit.dart';

import '../../services/repo.dart';
import '../../widgets/home/previous_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Previous extends StatefulWidget {
  @override
  _PreviousState createState() => _PreviousState();
}

class _PreviousState extends State<Previous> {
  final RepositoryIP repository = RepositoryIP();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InitialCubit>(
      create: (context) => InitialCubit(repository: repository),
      child: PreviousInfo(),
    );
  }
}
