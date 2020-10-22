import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchField extends StatelessWidget {
  final String page;

  const SearchField({Key key, this.page}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final InitialCubit ipCubit = context.bloc<InitialCubit>();
    TextEditingController searchController2 = TextEditingController();
    return TextField(
      onChanged: (textSearch) {
        //отправить евент, в jowCubit
        ipCubit.searchListJOW(searchData: textSearch.toString());
      },
      controller: searchController2,
      decoration: InputDecoration(
        hintText: "Поиск",
        prefixIcon: Icon(Icons.search),
        // border: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(25)))
      ),
    );
  }
}
