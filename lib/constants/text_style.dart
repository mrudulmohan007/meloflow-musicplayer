import 'package:flutter/material.dart';
import 'package:music_player/constants/colors.dart';

ourStyle({
  family = 'Poppins',
  double? size = 14,
  color = Colors.white,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: family,
  );
}
