import 'package:secur/src/totp/components/otp_type.dart';

abstract class OTPUtil {
  static String? otpTypeValue({OTPType? type}) {
    switch (type) {
      case OTPType.TOTP:
        return "totp";

      case OTPType.HOTP:
        return "hotp";

      default:
        return null;
    }
  }
}
