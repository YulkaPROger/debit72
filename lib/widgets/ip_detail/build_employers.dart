import 'package:debit72/models/ip_detail.dart';
import 'package:debit72/theme/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class BuildEmployers extends StatefulWidget {
  const BuildEmployers({
    Key key,
    @required this.ip,
    @required this.theme,
  }) : super(key: key);

  final IPDetail ip;
  final ThemeData theme;

  @override
  _BuildEmployersState createState() => _BuildEmployersState();
}

class _BuildEmployersState extends State<BuildEmployers> {

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
        height: widget.ip.employer.length > 0 ? 200 : 0,
        child: widget.ip.employer.length > 0
            ? ListView.builder(
                itemCount: widget.ip.employer.length,
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

  final BuildEmployers widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ListTile(
        leading: Icon(MaterialIcons.work,
            color: widget.ip.employer[index].foreclosure=="false"?widget.theme.accentColor:Colors.redAccent),
        title: Text(
          "Наименование: ${widget.ip.employer[index].employerName}",
        ),
        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              "Адрес: ${widget.ip.employer[index].employerAdres}",
            ),
            Text(
              "Дата актуальности: ${widget.ip.employer[index].dateRelevanceInfo}",
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

  final BuildEmployers widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ListTile(
        leading: Icon(MaterialIcons.work,
            color: widget.ip.employer[index].foreclosure=="false"?widget.theme.accentColor:Colors.redAccent),
        title: Text(
          "Обращение взыскания: ${widget.ip.employer[index].foreclosure}",
        ),
        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              "Дата обращения взыскания: ${widget.ip.employer[index].dateForeclosure}",
            ),
            Text(
              "ШПИ направления обращения: ${widget.ip.employer[index].shpi}",
            ),
          ],
        ),
      ),
    );
  }
}