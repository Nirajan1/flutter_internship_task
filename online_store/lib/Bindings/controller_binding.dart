import 'package:get/get.dart';
import 'package:online_store/Controller/product_list_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductListController());
  }
}
