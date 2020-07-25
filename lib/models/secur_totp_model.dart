import 'package:dart_otp/dart_otp.dart';
import 'package:flutter/foundation.dart';

class SecurTOTP {
  OTPAlgorithm algorithm;
  final int digits;
  final int interval;
  final String secret;
  final String issuer;

  SecurTOTP(
      {@required this.secret,
      this.algorithm = OTPAlgorithm.SHA1,
      this.digits = 6,
      this.interval = 30,
      this.issuer = "Generic Issuer"});

  String getTotp() {
    return TOTP(
      algorithm: algorithm,
      digits: digits,
      interval: interval,
      secret: secret,
    ).now();
  }
}
