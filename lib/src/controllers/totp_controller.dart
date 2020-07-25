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
}
