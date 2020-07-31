import 'package:barcode_scan/barcode_scan.dart';
import 'package:dart_otp/dart_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secur/src/controllers/totp_controller.dart';
import 'package:secur/src/models/securtotp.dart';
import 'package:supercharged/supercharged.dart';

Future<void> scanBarcode() async {
  try {
    ScanResult scanResult = await BarcodeScanner.scan();
    if (scanResult.isNullOrBlank ||
        scanResult.type == ResultType.Cancelled ||
        scanResult.type == ResultType.Error) {
      return;
    }

    var totp = totpBuild(scanResult.rawContent);
    if (totp == null) {
      _showErrorSnackbar("The QR code that you scanned was invalid.");
      return;
    }
    TOTPController.to.saveTotp(totp);
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.cameraAccessDenied) {
      _showErrorSnackbar('Grant camera access to proceed');
      await Permission.camera.request();
    } else {
      _showErrorSnackbar('Unknown error: $e');
      return;
    }
  } catch (e) {
    _showErrorSnackbar(e.toString());
    return;
  }
}

void _showErrorSnackbar(String error) {
  navigator.pop();
  Get.snackbar(
    'There seems to be a problem 😗',
    error,
    barBlur: 100,
    colorText: Colors.black87,
    icon: Icon(Icons.error_outline, color: Colors.red),
    animationDuration: 1.seconds,
    backgroundColor: Colors.white,
    duration: 3.seconds,
    margin: EdgeInsets.only(top: 10),
    borderRadius: 10,
    maxWidth: 420,
    isDismissible: true,
    shouldIconPulse: false,
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
      algorithm: algorithm == null ? "SHA1" : algorithm,
      issuer: issuer,
      accountName: parsedUri.pathSegments[0]);
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
