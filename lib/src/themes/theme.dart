import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supercharged/supercharged.dart';

final deepBlue = '#040D27'.toColor();
final deepBlueSecondary = '132147'.toColor();
final electricBlue = '2C5BED'.toColor();
final lightGrey = 'F0F0F0'.toColor();

const PREFS_BRIGHTNESS = 'shared_prefs_brightness';
const BRIGHNTESS_DARK = 'brightness_dark';
const BRIGHNTESS_LIGHT = 'brightness_light';
const BRIGHNTESS_SYSTEM = 'brightness_system';

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

final ThemeData darkTheme = ThemeData(
  accentColor: electricBlue,
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
  bottomSheetTheme: BottomSheetThemeData(
    modalBackgroundColor: deepBlueSecondary,
    shape: RoundedRectangleBorder(),
  ),
  iconTheme: IconThemeData(color: Colors.white.withOpacity(0.7)),
  dialogTheme: DialogTheme(
    backgroundColor: deepBlue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
);

final ThemeData lightTheme = ThemeData(
  accentColor: electricBlue,
  toggleableActiveColor: electricBlue,
  primaryColor: Colors.white,
  popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white),
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
      )),
  bottomSheetTheme: BottomSheetThemeData(
      modalBackgroundColor: Colors.white, shape: RoundedRectangleBorder()),
  textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Circular-Std'),
  iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
  dialogTheme: DialogTheme(
    backgroundColor: deepBlue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
);

final systemTheme = SystemUiOverlayStyle.light.copyWith(
  statusBarColor: Colors.transparent,
);

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

Color get textColor =>
    Get.theme.brightness == Brightness.light ? Colors.black87 : Colors.white;

ThemeData getTheme() {
  SharedPreferences prefs = Get.find();
  var brightness = prefs.getString(PREFS_BRIGHTNESS) ?? BRIGHNTESS_SYSTEM;
  switch (brightness) {
    case BRIGHNTESS_SYSTEM:
      var sysBrightness = WidgetsBinding.instance.window.platformBrightness;
      return sysBrightness == Brightness.light ? lightTheme : darkTheme;

    case BRIGHNTESS_LIGHT:
      return lightTheme;

    case BRIGHNTESS_DARK:
      return darkTheme;

    default:
      return darkTheme;
  }
}
