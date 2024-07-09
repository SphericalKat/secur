import 'package:hive/hive.dart';
import 'package:secur/src/services/barcode_scan.dart';
import 'package:secur/src/totp/totp.dart';

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
  final String? issuer;

  @HiveField(5)
  final String? accountName;

  SecurTOTP(
      {required this.secret,
      this.algorithm = "SHA1",
      this.digits = 6,
      this.interval = 30,
      this.issuer = "Generic Issuer",
      this.accountName});

  SecurTOTP.fromJson(Map<String, dynamic> json)
      : algorithm = json['algorithm'],
        digits = json['digits'],
        interval = json['interval'],
        secret = json['secret'],
        issuer = json['issuer'],
        accountName = json['accountName'];

  Map<String, dynamic> toJson() => {
        'algorithm': algorithm.toString(),
        'digits': digits,
        'interval': interval,
        'secret': secret,
        'issuer': issuer,
        'accountName': accountName
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
    return "SecurOTP{ 'secret': $secret, "
        "'algorithm': $algorithm, "
        "'digits': $digits, "
        "'interval': $interval, "
        "'issuer': $issuer, "
        "'accountName': $accountName }";
  }
}
