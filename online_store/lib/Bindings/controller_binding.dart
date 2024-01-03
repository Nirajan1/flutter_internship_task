import 'package:get/get.dart';
import 'package:online_store/Controller/cart_controller.dart';
import 'package:online_store/Controller/product_list_controller.dart';
import 'package:online_store/Controller/single_product_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductListController());
    Get.put(SingleProductController());
    Get.put(CartController());
  }
}
