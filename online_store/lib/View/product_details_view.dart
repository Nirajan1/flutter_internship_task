import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Controller/single_product_controller.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var singleProductController = Get.find<SingleProductController>();
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () {
            if (singleProductController.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.size.height * .3,
                      width: Get.size.width,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(9.0),
                              bottomRight: Radius.circular(9.0),
                            )),
                        child: Image.network(
                          '${singleProductController.productDetails.value.image}',
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
                    ),
                    Text(singleProductController.productDetails.value.title.toString()),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
