import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secur/src/models/securtotp.dart';
import 'package:secur/src/screens/homescreen/home.dart';
import 'package:secur/src/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SecurTOTPAdapter());
  await Hive.openBox('totp');

  runApp(Secur());
}

class Secur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    return GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: false,
      title: 'Secur',
      theme: theme,
      home: Home(),
    );
  }
}
