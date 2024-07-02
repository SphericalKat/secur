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
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive
  await Hive.initFlutter();
  Hive.registerAdapter(SecurTOTPAdapter());

  // init secure storage
  final storage = FlutterSecureStorage();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put(prefs);

  // attempt to fetch key from secure storage
  String? result = await storage.read(key: 'encryptionKey');
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

class Secur extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SecurState();
  }
}

class SecurState extends State<Secur> with WidgetsBindingObserver {
  ThemeData? theme;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    theme = getTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() {
      theme = getTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    return GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: false,
      title: 'Secur',
      theme: theme,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => Home(),
          customTransition: CustomSharedAxisTransition(),
          opaque: true,
        ),
        GetPage(
          name: '/form',
          page: () => SecurForm(),
          opaque: true,
          customTransition: CustomSharedAxisTransition()
        )
      ],
    );
  }
}
