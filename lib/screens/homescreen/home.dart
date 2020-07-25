import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:secur/components/custom_bottom_navbar.dart';
import 'package:secur/services/barcode_scan.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFloatingActionButton(context),
      bottomNavigationBar: CustomBottomNavBar(),
      body: homeBody(),
    );
  }
}

Widget homeBody() => SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Secur',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        // TODO : Add  BLoc
      ),
    );

FloatingActionButton buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: _bottomSheet,
    tooltip: 'Add secret',
    child: Icon(
      Icons.add,
      size: 35,
      color: Colors.black,
    ),
    elevation: 1.0,
  );
}

Future<Widget> _bottomSheet() {
  return Get.bottomSheet(
    Container(
      height: Get.mediaQuery.size.height / 5,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal,
          width: 1.3,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 100,
              child: IconButton(
                icon: Icon(
                  MaterialCommunityIcons.qrcode_scan,
                  size: 80,
                  color: Colors.pink[400],
                ),
                onPressed: () async => await scanBarcode(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 100,
              child: IconButton(
                  icon: Icon(
                    Octicons.keyboard,
                    size: 95,
                    color: CupertinoColors.systemBlue,
                  ),
                  onPressed: () {
                    navigator.pop();
                    Get.snackbar(
                      'TODO ',
                      'To be implemented',
                      barBlur: 0,
                      colorText: Colors.black87,
                      icon: Icon(Icons.error_outline, color: Colors.red),
                      animationDuration: Duration(milliseconds: 500),
                      backgroundColor: Colors.grey,
                      duration: Duration(seconds: 3),
                      margin: EdgeInsets.only(top: 13),
                      borderRadius: 20,
                      maxWidth: 360,
                      isDismissible: true,
                      shouldIconPulse: true,
                    );
                    // TODO : Add form support
                  }),
            ),
          ),
        ],
      ),
    ),
  );
}
