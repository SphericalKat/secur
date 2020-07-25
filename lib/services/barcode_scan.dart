import 'package:barcode_scan/barcode_scan.dart';
import 'package:dart_otp/dart_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secur/models/secur_totp_model.dart';
import 'package:supercharged/supercharged.dart';

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
    snackPosition: SnackPosition.BOTTOM,
  );
}

SecurTOTP totpBuild(String uri) {
  final parsedUri = Uri.parse(uri);
  final queryParams = parsedUri.queryParameters;

  final secret = queryParams['secret'];
  final issuer = queryParams['issuer'];
  final digits = queryParams['digits'];
  final algorithm = queryParams['algorithm'];

  if (secret == null) {
    return null;
  }

  return SecurTOTP(
    secret: secret,
    digits: digits == null ? 6 : digits.toInt(),
    algorithm: getAlgorithm(algorithm),
    issuer: issuer,
  );
}

OTPAlgorithm getAlgorithm(String algorithm) {
  if (algorithm == null) {
    return OTPAlgorithm.SHA1;
  }

  switch (algorithm) {
    case "SHA256":
      return OTPAlgorithm.SHA256;
    case "SHA1":
      return OTPAlgorithm.SHA1;
    case "SHA384":
      return OTPAlgorithm.SHA384;
    case "SHA512":
      return OTPAlgorithm.SHA512;
    default:
      return OTPAlgorithm.SHA1;
  }
}

permissionHandler() async {
  await Permission.camera.request();
  print(await Permission.camera.status);
}
