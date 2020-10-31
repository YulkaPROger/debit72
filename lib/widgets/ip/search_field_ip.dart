import 'package:debit72/theme/settings.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../cubit/initial/initial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFieldIP extends StatelessWidget {
  final String page;

  const SearchFieldIP({Key key, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final InitialCubit ipCubit = context.bloc<InitialCubit>();
    TextEditingController searchController = TextEditingController();
    return Column(children: [
      Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            lightSource: Provider.of<Settings>(context).isDarkMode
                ? LightSource.bottomRight
                : LightSource.topLeft,
            depth: -2,
            color: theme.buttonColor),
        child: TextField(
          onChanged: (textSearch) {
            //отправить евент, в jowCubit
            ipCubit.searchListIP(searchData: textSearch.toString());
          },
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Поиск",
            prefixIcon: Icon(Icons.search, color: theme.accentColor,),
            border: InputBorder.none
          ),
        ),
      ),
    ]);
    // return Column(
    //   children: [
    //     TextField(
    //       onChanged: (textSearch) {
    //         //отправить евент, в jowCubit
    //         ipCubit.searchListIP(searchData: textSearch.toString());
    //       },
    //       controller: searchController,
    //       decoration: InputDecoration(
    //         hintText: "Поиск",
    //         prefixIcon: Icon(Icons.search),
    //         // border: OutlineInputBorder(
    //         //     borderRadius: BorderRadius.all(Radius.circular(25)))
    //       ),
    //     ),

    //     //SearchItem(),
    //   ],
    // );
  }
}
