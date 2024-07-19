import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:secur/src/controllers/item_selection_controller.dart';
import 'package:secur/src/models/securtotp.dart';

class TOTPController extends GetxController {
  var db = Hive.box('totp');

  static TOTPController get to => Get.find();

  void saveTotp(SecurTOTP totp) {
    db.put(totp.secret, totp);
    update();
  }

  Future<void> saveAllTotps(List<SecurTOTP> totps) async {
    await db.putAll({ for (var e in totps) e.secret : e });
    update();
  }

  void deleteTotps(Set<dynamic> totps) {
    db.deleteAll(totps);
    ItemSelectionController.to.removeAllItems();
    update();
  }

  List<SecurTOTP> getAllTotps() {
    List<SecurTOTP> totps = [];
    for (var i = 0; i < db.length; i++) {
      totps.add(db.getAt(i));
    }
    return totps;
  }
}
