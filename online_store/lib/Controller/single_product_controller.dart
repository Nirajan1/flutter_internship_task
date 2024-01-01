import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Model/single_product_model.dart';
import 'package:online_store/Services/single_product_service.dart';

class SingleProductController extends GetxController {
  var productDetails = SingleProductModel(
    id: null,
    title: null,
    price: null,
    description: null,
    category: null,
    image: null,
    rating: null,
  ).obs;
  var isLoading = false.obs;
  Future fetchSingleProduct(int id) async {
    try {
      isLoading(true);
      var result = await RemoteSingleProductService.getSingleProduct(id);
      if (result != null) {
        productDetails.value = result;
      } else {
        return null;
      }
    } catch (exception) {
      debugPrint("ErrorL single product controller $exception");
    } finally {
      isLoading(false);
    }
  }
}
