///
/// @module   : TOTP module to generate and verify TOTP password
/// @author   : Gin (gin.lance.inside@hotmail.com)
///

import 'package:secur/src/totp/components/otp_algorithm.dart';

import 'otp.dart';
import 'components/otp_type.dart';
import 'utils/generic_util.dart';

///
/// TOTP class will generate the OTP (One Time Password) object with the current or given time.
class TOTP extends OTP {
  /// Period in which should be generated new tokens.
  int? interval;

  @override
  OTPType get type => OTPType.TOTP;

  @override
  Map<String, dynamic> get extraUrlProperties => {"period": interval};

  ///
  /// This constructor will create an TOTP instance.
  ///
  /// All parameters are mandatory however [interval],
  /// [digits] and [algorithm] have a default values, so can be ignored.
  ///
  /// Will throw an exception if the line above isn't satisfied.
  ///
  TOTP(
      {required String secret,
      int digits = 6,
      int? interval = 30,
      OTPAlgorithm algorithm = OTPAlgorithm.SHA1})
      : super(secret: secret, digits: digits, algorithm: algorithm) {
    this.interval = interval;
  }

  ///
  /// Generate the TOTP value with current time.
  ///
  /// ```dart
  /// TOTP totp = TOTP(secret: 'BASE32ENCODEDSECRET');
  /// totp.now(); // => 432143
  /// ```
  ///
  String now() {
    int _formatTime = Util.timeFormat(time: DateTime.now(), interval: interval!);
    return super.generateOTP(input: _formatTime);
  }

  ///
  /// Generate the OTP with a custom time.
  ///
  /// All parameters are mandatory.
  ///
  /// ```dart
  /// TOTP totp = TOTP(secret: 'BASE32ENCODEDSECRET');
  /// totp.value(date: DateTime.now()); // => 432143
  /// ```
  ///
  String? value({DateTime? date}) {
    if (date == null) {
      return null;
    }

    int _formatTime = Util.timeFormat(time: date, interval: interval!);
    return super.generateOTP(input: _formatTime);
  }

  ///
  /// Verifies the TOTP value passed in against the current time.
  ///
  /// All parameters are mandatory.
  ///
  /// ```dart
  /// TOTP totp = TOTP(secret: 'BASE32ENCODEDSECRET');
  /// totp.now(); // => 432143
  /// // Verify for current time
  /// totp.verify(otp: 432143); // => true
  /// // Verify after 30s
  /// totp.verify(otp: 432143); // => false
  /// ```
  ///
  bool verify({String? otp, DateTime? time}) {
    if (otp == null) {
      return false;
    }

    var _time = time ?? DateTime.now();
    var _input = Util.timeFormat(time: _time, interval: interval!);

    String otpTime = super.generateOTP(input: _input);
    return otp == otpTime;
  }
}