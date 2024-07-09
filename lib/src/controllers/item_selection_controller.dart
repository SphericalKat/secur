import 'package:get/get.dart';

class ItemSelectionController extends GetxController {
  Set selectedItems = <String?>{};

  static ItemSelectionController get to => Get.find();

  bool get areItemsSelected => selectedItems.isNotEmpty;

  void setSelectedItem(String? secret) {
    selectedItems.add(secret);
    update();
  }

  void removeSelectedItem(String? secret) {
    selectedItems.remove(secret);
    update();
  }

  void removeAllItems() {
    selectedItems.clear();
    update();
  }
}
