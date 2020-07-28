import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

final neonGreen = Color(0xff04C290);
final deepBlue = Color(0xff040D27);
final deepBlueSecondary = Color(0xff132147);
final electricBlue = Color(0xff2C5BED);

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
    inputDecorationTheme: inputTheme,
    pageTransitionsTheme: pageTransitionsTheme);

final systemTheme = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: deepBlue, statusBarColor: Colors.transparent);

class CustomSharedAxisTransition extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
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

class SizeTransitions extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve curve,
      Alignment alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return Align(
      alignment: Alignment.center,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animation,
          curve: curve,
        ),
        child: child,
      ),
    );
  }
}
