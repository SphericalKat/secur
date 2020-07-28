import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secur/src/models/securtotp.dart';
import 'package:secur/src/screens/formpage/secur_form.dart';
import 'package:secur/src/screens/homescreen/home.dart';
import 'package:secur/src/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive
  await Hive.initFlutter();
  Hive.registerAdapter(SecurTOTPAdapter());

  // init secure storage
  final storage = FlutterSecureStorage();

  // attempt to fetch key from secure storage
  String result = await storage.read(key: 'encryptionKey');
  List<int> encryptionKey;

  // if key does not exist already
  if (result == null) {
    // generate a new one
    encryptionKey = Hive.generateSecureKey();
    await storage.write(key: 'encryptionKey', value: jsonEncode(encryptionKey));
  } else {
    // otherwise use the existing key
    encryptionKey = List<int>.from(jsonDecode(result).whereType<int>());
  }

  // open the box using the key
  await Hive.openBox('totp', encryptionKey: encryptionKey);

  runApp(Secur());
}

class Secur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: false,
      title: 'Secur',
      theme: darkTheme,
      initialRoute: '/home',
      getPages: [
        GetPage(
            name: '/home',
            page: () => Home(),
            customTransition: CustomSharedAxisTransition()),
        GetPage(
            name: '/form',
            page: () => SecurForm(),
            customTransition: CustomSharedAxisTransition())
      ],
      customTransition: CustomSharedAxisTransition(),
    );
  }
}
