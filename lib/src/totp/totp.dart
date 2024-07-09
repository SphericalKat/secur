import 'otp.dart';
import 'components/otp_type.dart';
import 'utils/generic_util.dart';

///
/// TOTP class will generate the OTP (One Time Password) object with the current or given time.
class TOTP extends OTP {
  /// Period in which should be generated new tokens.
  int? interval;

  @override
  OTPType get tokenType => OTPType.TOTP;

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
      {required super.secret,
      super.digits,
      this.interval = 30,
      super.algorithm});

  ///
  /// Generate the TOTP value with current time.
  ///
  /// ```dart
  /// TOTP totp = TOTP(secret: 'BASE32ENCODEDSECRET');
  /// totp.now(); // => 432143
  /// ```
  ///
  String now() {
    int formatTime = Util.timeFormat(time: DateTime.now(), interval: interval!);
    return super.generateOTP(input: formatTime);
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

    int formatTime = Util.timeFormat(time: date, interval: interval!);
    return super.generateOTP(input: formatTime);
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

    var time0 = time ?? DateTime.now();
    var input = Util.timeFormat(time: time0, interval: interval!);

    String otpTime = super.generateOTP(input: input);
    return otp == otpTime;
  }
}
