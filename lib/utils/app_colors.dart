import 'package:flutter/material.dart';

class AppColors {
  static Color getColor(String? color) {
    switch (color) {
      case "red":
        return Colors.red;
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      case "yellow":
        return Colors.yellow;
      case "purple":
        return Colors.purple;
      case "orange":
        return Colors.orange;
      case "pink":
        return Colors.pink;
      case "cyan":
        return Colors.cyan;
      default:
        return const Color(0xFF111111);
    }
  }
}
