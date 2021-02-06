import 'package:debit72/models/ip_detail.dart';
import 'package:debit72/theme/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class BuildProperty extends StatefulWidget {
  const BuildProperty({
    Key key,
    @required this.ip,
    @required this.theme,
  }) : super(key: key);

  final IPDetail ip;
  final ThemeData theme;

  @override
  _BuildPropertyState createState() => _BuildPropertyState();
}

class _BuildPropertyState extends State<BuildProperty> {

  bool _displayFront;
  bool _flipXAxis;
  bool _showFrontSide;

  @override
  void initState() {
    super.initState();
    _displayFront = true;
    _flipXAxis = true;
    _showFrontSide = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.ip.property.length > 0 ? 250 : 0,
        child: widget.ip.property.length > 0
            ? ListView.builder(
                itemCount: widget.ip.property.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        lightSource:
                            Provider.of<Settings>(context)
                                    .isDarkMode
                                ? LightSource.bottomRight
                                : LightSource.topLeft,
                        depth: 2,
                        color: widget.theme.buttonColor),
                    margin: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () => setState(() =>_showFrontSide = !_showFrontSide),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 600),
                        child: _showFrontSide
                        ?GeneralInformation(widget: widget, index: index)
                        :AdditionalInformation(widget: widget, index: index),
                      )
                      ),
                  );
                })
            : Container());
  }
}

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({
    Key key,
    @required this.widget,
    this.index
  }) : super(key: key);

  final BuildProperty widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ListTile(
        leading: Icon(
          Ionicons.ios_home,
          color: widget.ip.property[index].arrested==false? widget.theme.accentColor:Colors.redAccent,
        ),
        title: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                "${widget.ip.property[index].propertyClaimant}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdditionalInformation extends StatelessWidget {
  const AdditionalInformation({
    Key key,
    @required this.widget,
    this.index
  }) : super(key: key);

  final BuildProperty widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ListTile(
        leading: Icon(
          Ionicons.ios_home,
          color: widget.ip.property[index].arrested==false? widget.theme.accentColor:Colors.redAccent,
        ),
        title: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Арестовано: ${widget.ip.property[index].arrested}",
            ),
            Text(
              "Дата описи ареста: ${widget.ip.property[index].dateInventaryArested}",
            ),
            Text(
              "Сумма по оценке: ${widget.ip.property[index].amountInventary}",
            ),
          ],
        ),
      ),
    );
  }
}