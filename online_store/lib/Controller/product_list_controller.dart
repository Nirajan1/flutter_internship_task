import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Model/product_list_model.dart';
import 'package:online_store/Services/product_list_service.dart';

class ProductListController extends GetxController {
  var productList = <AllProductModel>[].obs;
  var isLoading = false.obs;
  Future getProductList() async {
    try {
      isLoading(true);
      var result = await RemoteProductListService.getProductList();
      if (result != null) {
        productList.value = result;
      } else {
        return null;
      }
    } catch (exception) {
      debugPrint("ErrorL product list controller $exception");
    } finally {
      isLoading(false);
    }
  }

//* on initialization all the products will be loaded in the home screen
  @override
  void onInit() {
    super.onInit();
    getProductList();
  }
}
