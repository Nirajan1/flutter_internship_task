import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_store/Model/single_product_model.dart';
import 'package:online_store/Utils/http_client.dart';

class RemoteSingleProductService {
  static Future getSingleProduct(int id) async {
    try {
      var response = await HttpClient.client.get(
        Uri.parse("https://fakestoreapi.com/products/$id"),
        headers: HttpClient.headers,
      );
      var responseResult = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return SingleProductModel.fromJson(responseResult);
      }
    } catch (exception) {
      debugPrint("ErrorL single product service $exception");
    }
    return null;
  }
}
