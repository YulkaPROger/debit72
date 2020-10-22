// import 'package:app_for_arest/cubit/initial/initial_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// import '../../constants.dart';

// List<String> searchItem = [
//   "Номер ИД",
//   "Номер дела",
//   "Должник",
//   "Взыскатель",
//   "Улица фонда",
//   "Дом фонда",
//   "Квартира фонда",
//   "РОСП",
//   "СПИ"
// ];

// class SearchItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<InitialCubit, InitialState>(builder: (context, state) {
//       return Expanded(
//         flex: 1,
//         child: ListView.builder(
//             padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
//             scrollDirection: Axis.horizontal,
//             itemCount: searchItem.length,
//             itemBuilder: (context, index) {
//               return Neumorphic(
//                 margin: EdgeInsets.only(right: 8, top: 2),
//                 child: NeumorphicButton(
//                   onPressed: () {},
//                   style: NeumorphicStyle(
//                       color:
//                           // state == index
//                           //     ? NeumorphicTheme.currentTheme(context).accentColor
//                           //     :
//                           NeumorphicTheme.currentTheme(context).baseColor),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 8,
//                   ),
//                   child: Text(
//                     "${searchItem[index]}",
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               );
//             }),
//       );
//     });
//   }
// }
