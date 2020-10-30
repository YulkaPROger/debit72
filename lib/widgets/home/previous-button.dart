import 'package:debit72/theme/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class ButtonMenu extends StatelessWidget {
  const ButtonMenu({
    Key key,
    @required this.theme, this.textButton, this.textPages,
  }) : super(key: key);

  final ThemeData theme;
  final String textButton;
  final String textPages;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        lightSource: Provider.of<Settings>(context).isDarkMode?LightSource.bottomRight:LightSource.topLeft,
        depth: 2,
        color: theme.buttonColor
      ),
      onPressed: (){
        Navigator.pushNamed(context, '$textPages');
      },
      child: Text(textButton),
    );
  }
}