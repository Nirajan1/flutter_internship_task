import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Controller/product_list_controller.dart';
import 'package:online_store/Controller/single_product_controller.dart';
import 'package:online_store/Model/product_list_model.dart';
import 'package:online_store/Utils/app_size.dart';

import '../Widgets/add_to_cart_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allProductListController = Get.find<ProductListController>();
    var singleProductController = Get.find<SingleProductController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('OnlineStore'),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.0),
              child: Icon(Icons.shopping_cart_outlined),
            ),
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
                    child: GridView.builder(
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
                                      ), //* Add to cart button

                                      const SizedBox(height: 4.0),

                                      const AddToCartButton(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
