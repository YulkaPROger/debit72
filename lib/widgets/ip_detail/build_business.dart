import 'package:debit72/models/ip_detail.dart';
import 'package:debit72/theme/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class BuildBusines extends StatelessWidget {
  const BuildBusines({
    Key key,
    @required this.ip,
    @required this.theme,
  }) : super(key: key);

  final IPDetail ip;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ip.busines.length > 0 ? 300 : 0,
        child: ip.busines.length > 0
            ? ListView.builder(
                itemCount: ip.busines.length,
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
                        color: theme.buttonColor),
                    margin: const EdgeInsets.all(8),
                    child: Container(
                      width: 300,
                      child: ListTile(
                        leading: Icon(
                          Ionicons.ios_business,
                          color: theme.accentColor,
                        ),
                        title: Text(
                          "Наименование: ${ip.busines[index].propertyBusines}",
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Адрес: ${ip.busines[index].adresBusines}",
                            ),
                            Text(
                              "ИНН: ${ip.busines[index].inn}",
                            ),
                            Text(
                              "ОГРН: ${ip.busines[index].ogrn}",
                            ),
                            Text(
                              "Размер доли: ${ip.busines[index].sizeShare}",
                            ),
                            Text(
                              "Стоимость доли: ${ip.busines[index].valueShare}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Container());
  }
}