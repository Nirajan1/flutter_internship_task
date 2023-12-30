import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_store/Model/product_list_model.dart';
import 'package:online_store/Utils/http_client.dart';

class RemoteProductListService {
  static Future<List<AllProductModel>?> getProductList() async {
    try {
      var response = await HttpClient.client.get(
        Uri.parse("https://fakestoreapi.com/products"),
        headers: HttpClient.headers,
      );
      var jsonString = response.body;
      print(jsonString);
      if (response.statusCode == 200) {
        return allProductModelFromJson(jsonString);
      }
    } catch (exception) {
      debugPrint("ErrorL product list service $exception");
    }
    return null;
  }
}
