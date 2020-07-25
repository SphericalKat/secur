import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:secur/services/barcode_scan.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      body: homeBody(context),
      appBar: appBar(context),
    );
  }
}

Widget appBar(context) => AppBar(
      title: RichText(
        text: TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "Circular-Std",
            ),
            children: [
              TextSpan(
                  text: 'Sec',
                  style: TextStyle(color: Theme.of(context).accentColor)),
              TextSpan(text: 'ur', style: TextStyle(color: Colors.white))
            ]),
      ),
      shadowColor: Theme.of(context).primaryColor,
      centerTitle: true,
    );

Widget homeBody(context) => SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ),
        // TODO : Add  BLoc
      ),
    );

FloatingActionButton buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      _bottomSheet(context);
    },
    tooltip: 'Add secret',
    child: Icon(
      Icons.add,
      color: Colors.white,
    ),
    elevation: 1.0,
  );
}

void _bottomSheet(context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).primaryColor,
    builder: (BuildContext bc) {
      return Container(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(MaterialCommunityIcons.qrcode_scan),
              title: Text("Scan QR code"),
              onTap: () async => await scanBarcode(),
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.keyboard),
              title: Text("Enter a provided key"),
              onTap: () {
                navigator.pop();
                Get.snackbar(
                  'TODO',
                  'To be implemented',
                  barBlur: 0.5,
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.black87,
                  icon: Icon(Icons.error_outline, color: Colors.red),
                  animationDuration: Duration(milliseconds: 500),
                  backgroundColor: Colors.white,
                  duration: Duration(seconds: 3),
                  borderRadius: 10,
                  maxWidth: 420,
                  isDismissible: true,
                  shouldIconPulse: false,
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
