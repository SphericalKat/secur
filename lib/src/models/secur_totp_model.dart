import 'package:dart_otp/dart_otp.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class SecurTOTP extends HiveObject {

  @HiveField(0)
  final OTPAlgorithm algorithm;

  @HiveField(1)
  final int digits;

  @HiveField(2)
  final int interval;

  @HiveField(3)
  final String secret;

  @HiveField(4)
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

  @override
  String toString() {
    return "SecurOTP{ 'secret': ${this.secret}, 'algorithm': ${this.algorithm}, 'digits': ${this.digits}, 'interval': ${this.interval}, 'issuer': ${this.issuer} }";
  }
}
