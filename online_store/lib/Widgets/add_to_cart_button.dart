import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Controller/cart_controller.dart';
import 'package:online_store/Model/product_list_model.dart';
import 'package:online_store/Utils/app_color.dart';
import 'package:online_store/Utils/app_size.dart';
import 'package:online_store/Utils/local_storage.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.cartController,
    required this.items,
  });

  final CartController cartController;
  final AllProductModel items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.hPadding),
      child: SizedBox(
        height: 50,
        width: Get.size.width * .33,
        child: MaterialButton(
          elevation: .3,
          color: AppColor.ionColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(9.0),
            ),
          ),
          onPressed: () async {
            if (LocalStorage.accessToken == null) {
              Get.offAllNamed('/login');
            } else {
              // Check if the product is already in the cart
              if (cartController.isProductInCart(items)) {
                // Show a Snackbar message
                Get.snackbar(
                  'Already in Cart'.tr,
                  '${items.title} ${'is already in your cart'.tr}',
                  isDismissible: true,
                  snackPosition: SnackPosition.BOTTOM,
                );
              } else {
                // Add the product to the cart
                cartController.addToCart(items);
                // Show a confirmation message
                Get.snackbar(
                  'Added to Cart'.tr,
                  '${items.title} ${'added to the cart'.tr}',
                  isDismissible: true,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_shopping_cart_outlined,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 6.0),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Add to cart'.tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
