import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Controller/cart_controller.dart';
import 'package:online_store/Controller/single_product_controller.dart';
import 'package:online_store/Services/product_list_service.dart';
import 'package:online_store/Utils/app_color.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  @override
  Widget build(BuildContext context) {
    var singleProductController = Get.find<SingleProductController>();
    var cartController = Get.find<CartController>();
    //*this method is used to make a search query form the remote product list service
    void searchProduct(String query) {
      //*clear any previous search results in list
      RemoteProductListService.searchResults.clear();
      RemoteProductListService.searchResults.addAll(RemoteProductListService.allProducts.where((product) {
        return product['title'].toString().toLowerCase().contains(query.toLowerCase());
      }));
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            width: Get.size.width * 2,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search in OnlineStore'.tr,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                suffixIcon: const Icon(
                  Icons.search_outlined,
                  color: AppColor.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
              onChanged: (query) {
                searchProduct(query);
              },
            ),
          ),
          actions: [
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
          ],
        ),
        body: Obx(
          () {
            if (RemoteProductListService.searchResults.isEmpty) {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'No such products found',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: RemoteProductListService.searchResults.length,
                itemBuilder: (context, index) {
                  final product = RemoteProductListService.searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      width: Get.size.width,
                      height: 100,
                      child: Card(
                        elevation: 2,
                        color: Colors.white,
                        child: ListTile(
                          leading: SizedBox(
                            height: Get.size.height,
                            width: 50,
                            child: Image.network(
                              product['image'],
                              fit: BoxFit.contain,
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
                            product['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          subtitle: Text(
                            'Rs ${product['price']}',
                          ),
                          onTap: () {
                            singleProductController.fetchSingleProduct(product['id']);
                            Get.toNamed('/ProductDetailPage');
                          },
                          // Add more details as needed
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
