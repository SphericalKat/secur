import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supercharged/supercharged.dart';

final deepBlue = '#040D27'.toColor();
final deepBlueSecondary = '132147'.toColor();
final electricBlue = '2C5BED'.toColor();
final lightGrey = 'F0F0F0'.toColor();

final InputDecorationTheme inputTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: electricBlue),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: electricBlue),
  ),
);

final pageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: SharedAxisPageTransitionsBuilder(
        transitionType: SharedAxisTransitionType.scaled,
        fillColor: Color(0xff1d1f3e)),
  },
);

final ThemeData darkTheme = ThemeData(
  accentColor: electricBlue,
  primaryColor: deepBlue,
  primaryColorDark: deepBlue,
  backgroundColor: deepBlue,
  scaffoldBackgroundColor: deepBlue,
  cardColor: deepBlueSecondary,
  fontFamily: "Circular-Std",
  applyElevationOverlayColor: true,
  brightness: Brightness.dark,
  inputDecorationTheme: inputTheme,
  pageTransitionsTheme: pageTransitionsTheme,
);

final ThemeData lightTheme = ThemeData(
    accentColor: electricBlue,
    primaryColor: Colors.white,
    primaryColorDark: Colors.white,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    cardColor: lightGrey,
    fontFamily: "Circular-Std",
    applyElevationOverlayColor: true,
    brightness: Brightness.light,
    inputDecorationTheme: inputTheme,
    pageTransitionsTheme: pageTransitionsTheme,
    cardTheme: CardTheme(
      elevation: 0,
    ),
);

final systemTheme = SystemUiOverlayStyle.light.copyWith(
  statusBarColor: Colors.transparent,
);

class CustomSharedAxisTransition extends CustomTransition {
  @override
  Widget buildTransition(BuildContext context,
      Curve curve,
      Alignment alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.scaled,
      child: child,
    );
  }
}

Color get textColor =>
    Get.theme.brightness == Brightness.light ? Colors.black87 : Colors.white;