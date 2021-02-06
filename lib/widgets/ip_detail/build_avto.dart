import 'package:debit72/models/ip_detail.dart';
import 'package:debit72/theme/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class BuildAvtoWidget extends StatefulWidget {
  const BuildAvtoWidget({
    Key key,
    @required this.ip,
    @required this.theme,
  }) : super(key: key);

  final IPDetail ip;
  final ThemeData theme;

  @override
  _BuildAvtoWidgetState createState() => _BuildAvtoWidgetState();
}

class _BuildAvtoWidgetState extends State<BuildAvtoWidget> {
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
        height: widget.ip.avto.length > 0 ? 150 : 0,
        child: widget.ip.avto.length > 0
            ? ListView.builder(
                itemCount: widget.ip.avto.length,
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
                        ?GeneralInformation(ip: widget.ip, theme: widget.theme, index: index)
                      :AdditionalInformation(ip: widget.ip, theme: widget.theme, index: index)
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
    @required this.ip,
    @required this.theme,
    this.index
  }) : super(key: key);

  final IPDetail ip;
  final ThemeData theme;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ListTile(
        leading: Icon(Ionicons.ios_car,
            color: ip.avto[index].arrested==false?theme.accentColor: Colors.redAccent),
        title: Text(
          "${ip.avto[index].avto}",
        ),
        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              "Модель: ${ip.avto[index].model}",
            ),
            Text(
              "Гос. номер: ${ip.avto[index].stateNumber}",
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
    @required this.ip,
    @required this.theme,
    this.index
  }) : super(key: key);

  final IPDetail ip;
  final ThemeData theme;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ListTile(
        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              "Дата ареста ТС: ${ip.avto[index].dateArrested}",
            ),
            Text(
              "Сумма по оценке: ${ip.avto[index].amountEstimated}",
            ),
            Text(
              "Место хранения ${ip.avto[index].storage}",
            ),
          ],
        ),
      ),
    );
  }
}