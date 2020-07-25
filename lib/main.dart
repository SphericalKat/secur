import 'package:flutter/material.dart';
import 'package:secur/screens/homescreen/home.dart';
import 'package:secur/themes/theme.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    Secur(),
  );
}

class Secur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: false,
      title: 'Secur',
      theme: theme,
      home: Home(),
    );
  }
}
