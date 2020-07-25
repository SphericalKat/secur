import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secur/models/secur_totp_model.dart';

Future scanBarcode() async {
  try {
    ScanResult scanResult = await BarcodeScanner.scan();
    totpBuild(scanResult.rawContent);
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.cameraAccessDenied) {
      _showErrorSnackbar('Grant camera access to proceed');
      await permissionHandler();
    } else {
      _showErrorSnackbar('Unknown error: $e');
    }
  } catch (e) {
    _showErrorSnackbar(e.toString());
  }
}

void _showErrorSnackbar(String error) {
  Get.snackbar(
    'There seems to be a problem 😗',
    error,
    barBlur: 100,
    colorText: Colors.black87,
    icon: Icon(Icons.error_outline, color: Colors.red),
    animationDuration: Duration(milliseconds: 500),
    backgroundColor: CupertinoColors.white,
    duration: Duration(seconds: 3),
    margin: EdgeInsets.only(top: 10),
    borderRadius: 20,
    maxWidth: 360,
    isDismissible: true,
    shouldIconPulse: true,
  );
}

SecurTOTP totpBuild(String uri) {
  var parsedUri = Uri.parse(uri);
  var secret = parsedUri.queryParameters['secret'];
  var issuer = parsedUri.queryParameters['issuer'];

  return SecurTOTP(
    secret: secret
  );
}

permissionHandler() async {
  await Permission.camera.request();
  print(await Permission.camera.status);
}
