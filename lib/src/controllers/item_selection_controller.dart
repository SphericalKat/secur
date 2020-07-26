import 'package:get/get.dart';

class ItemSelectionController extends GetxController {
  Set selectedItems = Set<int>();

  static ItemSelectionController get to => Get.find();

  bool get areItemsSelected => selectedItems.isNotEmpty;

  void setSelectedItem(int index) {
    selectedItems.add(index);
    update();
  }

  void removeSelectedItem(int index) {
    selectedItems.remove(index);
    update();
  }

  void removeAllItems() {
    selectedItems.clear();
    update();
  }
}
