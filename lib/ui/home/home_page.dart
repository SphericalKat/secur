import 'package:flutter/material.dart';
import 'package:secur/ui/common/secur_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecurAppBar(),
      body: Container(),
    );
  }
}
