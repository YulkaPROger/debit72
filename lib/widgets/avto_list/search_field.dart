import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFieldAvto extends StatelessWidget {
  const SearchFieldAvto({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InitialCubit ipCubit = context.bloc<InitialCubit>();
    TextEditingController searchControllerAvto = TextEditingController();
    return Column(children: [
      TextField(
        onChanged: (textSearch) {
          //отправить евент, в jowCubit
          ipCubit.searchListAvto(searchData: textSearch.toString());
        },
        controller: searchControllerAvto,
        decoration: InputDecoration(
          hintText: "Поиск",
          prefixIcon: Icon(Icons.search),
          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(25)))
        ),
      ),
    ]);
  }
}
