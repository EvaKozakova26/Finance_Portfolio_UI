import 'dart:ui';

import 'package:flutter/material.dart';

class ColorUtils {

  static Color? mapColor(String symbol) {
    Map<String, Color?> colorMap = {
      'btc': Colors.amber[400],
      'MONET.PR': Colors.deepPurple[900],
      'CEZ.PR': Colors.orange[900],
      'INTC': Colors.blue[200],
      'SOFI': Colors.indigo,
      'SPY': Colors.lightGreen[300],
      'MCD': Colors.red[800],
      'TABAK.PR': Colors.blue,
      'SPG': Colors.black87,
      'FB': Colors.blue[900],
    };
    return colorMap[symbol];
  }
}