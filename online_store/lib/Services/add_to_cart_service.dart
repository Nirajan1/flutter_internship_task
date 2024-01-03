import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_store/Utils/http_client.dart';

class RemoteAddToCartService {
  static Future addToCart(var data) async {
    try {
      var response = await HttpClient.client.post(
        Uri.parse('https://fakestoreapi.com/carts'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
      } else {}
    } catch (exception) {
      debugPrint('ErrorL remote add to cart service $exception');
    }
  }
}
