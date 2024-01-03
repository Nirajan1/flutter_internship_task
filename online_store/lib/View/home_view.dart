import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Controller/cart_controller.dart';
import 'package:online_store/Controller/product_list_controller.dart';
import 'package:online_store/Controller/single_product_controller.dart';
import 'package:online_store/Model/product_list_model.dart';
import 'package:online_store/Utils/app_size.dart';
import 'package:online_store/Utils/local_storage.dart';
import 'package:online_store/Widgets/logout_button.dart';

import '../Widgets/add_to_cart_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allProductListController = Get.find<ProductListController>();
    var singleProductController = Get.find<SingleProductController>();
    var cartController = Get.find<CartController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('OnlineStore'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: InkWell(
                  onTap: () {
                    Get.toNamed('/SearchPage');
                  },
                  child: const Icon(Icons.search_outlined)),
            ),
            Obx(
              () => Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed('/CartListViewPage');
                      },
                      icon: const Icon(Icons.shopping_cart_outlined)),
                  Positioned(
                    right: 10,
                    top: 6,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${cartController.cartItems.length}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            LocalStorage.accessToken != null
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9.0),
                    child: LogoutButton(),
                  )
                : const SizedBox(),
          ],
        ),
        body: Obx(
          () {
            if (allProductListController.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.sPadding, vertical: AppSize.sPadding),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed('/SearchPage');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSize.hPadding,
                              vertical: 10,
                            ),
                            child: Container(
                                height: 50,
                                width: Get.size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.0),
                                  color: Colors.white,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Search in OnlineStore',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.search_outlined,
                                        size: 19,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.76,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(5),
                          shrinkWrap: true,
                          itemCount: allProductListController.productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var items = allProductListController.productList[index];
                            return InkWell(
                              onTap: () {
                                singleProductController.fetchSingleProduct(items.id);
                                Get.toNamed('/ProductDetailPage');
                              },
                              child: Card(
                                elevation: 1, // Adjust the elevation as needed
                                surfaceTintColor: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //*image and product title
                                    ImageTitleWidget(items: items),

                                    //*prince and button
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //*price Section for the product
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: 'Rs ',
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(
                                                    text: "${items.price}",
                                                    style: Get.textTheme.titleMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 4.0),
                                          //* Add to cart button
                                          AddToCartButton(
                                            cartController: cartController,
                                            items: items,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )),
              );
            }
          },
        ),
      ),
    );
  }
}

class ImageTitleWidget extends StatelessWidget {
  const ImageTitleWidget({
    super.key,
    required this.items,
  });

  final AllProductModel items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 157,
      child: Column(
        children: [
          //*image section
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: SizedBox(
              height: 110, // Adjust the height as needed
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9.0),
                  topRight: Radius.circular(9.0),
                ),
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
            ),
          ),
          //*product title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: SizedBox(
              width: Get.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      items.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Get.textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
