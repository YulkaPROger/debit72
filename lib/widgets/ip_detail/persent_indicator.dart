import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class PersentIndicator extends StatelessWidget {
  final double percent;
  const PersentIndicator({
    Key key,
    this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxPersent = 1.00;
    double minPersent = -1.00;
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0, right: 8.0),
      child: (percent > maxPersent) || (percent < minPersent)
      ?Container(
      )
      :NeumorphicProgress(
        duration: Duration(microseconds: 1500),
        height: 12,
        style: ProgressStyle(
            depth: -2,
            accent: percent < 0 ? Colors.red : theme.accentColor,
            variant: percent < 0 ? Colors.red : theme.indicatorColor),
        percent: percent < 0 ? percent * (-1) : percent,
      ),
    );
  }
}