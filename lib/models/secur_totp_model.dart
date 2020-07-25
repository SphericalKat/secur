import 'package:dart_otp/dart_otp.dart';
import 'package:flutter/foundation.dart';

class SecurTOTP {
   dynamic algorithm;
   int digits;
   int interval;
  final String secret;

  SecurTOTP({
    @required this.secret,
    this.algorithm = OTPAlgorithm.SHA256,
    this.digits = 6,
    this.interval = 30,
  });

  String getTotp() {
    return TOTP(
      algorithm: algorithm ,
      digits: digits,
      interval: interval,
      secret: secret,
    ).now();
  }
}


