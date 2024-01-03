import 'package:get/get.dart';
import 'package:online_store/Model/product_list_model.dart';

class CartController extends GetxController {
  var cartItems = <AllProductModel>[].obs;

  void addToCart(AllProductModel product) {
    cartItems.add(product);
  }

//? logic to check is the cart list already contains the same product or not and send alert message
  bool isProductInCart(AllProductModel product) {
    return cartItems.contains(product);
  }
}
