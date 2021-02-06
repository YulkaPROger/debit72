import 'package:debit72/models/ip_detail.dart';
import 'package:debit72/theme/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class BuildSetlementsAccount extends StatelessWidget {
  const BuildSetlementsAccount({
    Key key,
    @required this.ip,
    @required this.theme,
  }) : super(key: key);

  final IPDetail ip;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ip.setlementsAccounts.length > 0 ? 100 : 0,
        child: ip.setlementsAccounts.length > 0
            ? ListView.builder(
                itemCount: ip.setlementsAccounts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          lightSource:
                              Provider.of<Settings>(context)
                                      .isDarkMode
                                  ? LightSource.bottomRight
                                  : LightSource.topLeft,
                          depth: 2,
                          color: theme.buttonColor),
                      child: Container(
                        width: 300,
                        child: ListTile(
                          leading: Icon(Entypo.credit_card,
                              color: theme.accentColor),
                          title: Text(
                            "${ip.setlementsAccounts[index].number}",
                          ),
                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Тип счета: ${ip.setlementsAccounts[index].accountType}",
                              ),
                              Text(
                                "БАНК: ${ip.setlementsAccounts[index].bank}",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : Container());
  }
}

