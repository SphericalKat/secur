import 'package:flutter/material.dart';

const deepBlue = Color(0xFF040D27);
const deepBlueSecondary = Color(0xFF132147);
const electricBlue = Color(0xFF2C5BED);
const lightGrey = Color(0xFFF0F0F0);

final InputDecorationTheme inputTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(color: electricBlue, width: 1.4),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(color: electricBlue, width: 1.4),
  ),
);

final ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: deepBlue,
    secondary: electricBlue,
    onSecondary: Colors.white,
    surface: deepBlue,
  ),
  primaryColor: deepBlue,
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  primaryColorDark: deepBlue,
  backgroundColor: deepBlue,
  scaffoldBackgroundColor: deepBlue,
  cardColor: deepBlueSecondary,
  applyElevationOverlayColor: true,
  brightness: Brightness.dark,
  inputDecorationTheme: inputTheme,
  toggleableActiveColor: electricBlue,
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Circular-Std'),
  bottomSheetTheme: const BottomSheetThemeData(
    modalBackgroundColor: deepBlueSecondary,
    shape: RoundedRectangleBorder(),
  ),
  iconTheme: IconThemeData(color: Colors.white.withOpacity(0.7)),
  dialogTheme: DialogTheme(
    backgroundColor: deepBlue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    buttonColor: electricBlue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
);

final ThemeData lightTheme = ThemeData(
  toggleableActiveColor: electricBlue,
  colorScheme: const ColorScheme.light(
    primary: Colors.white,
    secondary: electricBlue,
    onSecondary: Colors.white,
  ),
  primaryColor: Colors.white,
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: Colors.white,
  ),
  primaryColorDark: Colors.white,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  cardColor: lightGrey,
  fontFamily: "Circular-Std",
  applyElevationOverlayColor: true,
  brightness: Brightness.light,
  inputDecorationTheme: inputTheme,
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: Colors.white, shape: RoundedRectangleBorder()),
  textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Circular-Std'),
  iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
  dialogTheme: DialogTheme(
    backgroundColor: deepBlue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    buttonColor: electricBlue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
);
