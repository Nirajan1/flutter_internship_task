import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Model/product_list_model.dart';
import 'package:online_store/Utils/http_client.dart';

class RemoteProductListService {
  //  to hold all product list for searching
  static RxList<Map<String, dynamic>> allProducts = <Map<String, dynamic>>[].obs;
  // RxList to hold search results
  static RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;
  static Future<List<AllProductModel>?> getProductList() async {
    try {
      var response = await HttpClient.client.get(
        Uri.parse("https://fakestoreapi.com/products"),
        headers: HttpClient.headers,
      );
      var jsonString = response.body;
      if (response.statusCode == 200) {
        allProducts.addAll(List<Map<String, dynamic>>.from(jsonDecode(response.body)));
        // Initially, display all products
        searchResults.addAll(allProducts);
        return allProductModelFromJson(jsonString);
      }
    } catch (exception) {
      debugPrint("ErrorL product list service $exception");
    }
    return null;
  }
}
