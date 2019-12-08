import 'package:desafio_toro/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

Widget chartCard(List quotesReadings) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Sparkline(
      fillMode: FillMode.below,
      fillGradient: LinearGradient(colors: [Colors.transparent, kColorsAccent.withOpacity(0.1), kColorsAccent], begin: Alignment.bottomCenter, end: Alignment.topCenter, stops: [0, 0.3, 0.9]),
      lineColor: Colors.white60,
      data: (quotesReadings),
    ),
  );
}
