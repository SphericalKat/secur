import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:secur/src/models/securtotp.dart';

class TOTPController extends GetxController {
  var db = Hive.box('totp');

  static TOTPController get to => Get.find();

  void saveTotp(SecurTOTP totp) {
    db.add(totp);
    update();
  }

  int getTotpKey(SecurTOTP totp) {
    var savedMap =
        Map.fromIterables(db.values.map((e) => e.secret), db.keys);
    return savedMap[totp.secret];
  }
}
