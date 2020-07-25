import 'package:dart_otp/dart_otp.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:secur/src/services/barcode_scan.dart';

part 'securtotp.g.dart';

@HiveType(typeId: 0)
class SecurTOTP extends HiveObject {
  @HiveField(0)
  final String algorithm;

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
      this.algorithm = "SHA1",
      this.digits = 6,
      this.interval = 30,
      this.issuer = "Generic Issuer"});

  SecurTOTP.fromJson(Map<String, dynamic> json)
      : algorithm = json['algorithm'],
        digits = json['digits'],
        interval = json['interval'],
        secret = json['secret'],
        issuer = json['issuer'];

  Map<String, dynamic> toJson() => {
        'algorithm': algorithm.toString(),
        'digits': digits,
        'interval': interval,
        'secret': secret,
        'issuer': issuer,
      };

  String getTotp() {
    return TOTP(
      algorithm: getAlgorithm(algorithm),
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
