import 'package:debit72/theme/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class PreviousIcon extends StatelessWidget {
  const PreviousIcon({
    Key key,
    @required this.theme, this.icons,
  }) : super(key: key);

  final ThemeData theme;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      child: Icon(icons, color: theme.accentColor, size: 36,),
      
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        lightSource: Provider.of<Settings>(context).isDarkMode?LightSource.bottomRight:LightSource.topLeft,
        boxShape: NeumorphicBoxShape.circle(),
        depth: 2,
        color: theme.buttonColor
      ),
      onPressed: (){},
    );
  }
}