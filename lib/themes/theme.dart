import 'package:flutter/material.dart';

final neonGreen = Color(0xff04C290);
final deepBlue = Color(0xff040D27);
final deepBlueSecondary = Color(0xff132147);
final electricBlue = Color(0xff2C5BeD);

final ThemeData theme = ThemeData(
  accentColor: electricBlue,
  primaryColor: deepBlue,
  primaryColorDark: deepBlue,
  backgroundColor: deepBlue,
  scaffoldBackgroundColor: deepBlue,
  cardColor: deepBlueSecondary,
  fontFamily: "Circular-Std",
  applyElevationOverlayColor: true,
  brightness: Brightness.dark,
);
