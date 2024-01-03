import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Controller/cart_controller.dart';
import 'package:online_store/Controller/single_product_controller.dart';
import 'package:online_store/Services/single_product_service.dart';

class CartListViewPage extends StatelessWidget {
  const CartListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var singleProductController = Get.find<SingleProductController>();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
            centerTitle: true,
          ),
          body: Obx(
            () => cartController.cartItems.isEmpty
                ? const Center(
                    child: Text('cart is empty'),
                  )
                : ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      var items = cartController.cartItems[index];
                      return Card(
                        elevation: .2,
                        child: ListTile(
                          leading: SizedBox(
                            height: 80,
                            width: 60,
                            child: Image.network(
                              items.image,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return CircularProgressIndicator.adaptive(
                                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                          title: Text(
                            items.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          subtitle: Text(
                            'Rs ${items.price}',
                          ),
                          onTap: () async {
                            RemoteSingleProductService.getSingleProduct(items.id);
                            Get.toNamed('/ProductDetailPage');
                          },
                        ),
                      );
                    },
                  ),
          )),
    );
  }
}
