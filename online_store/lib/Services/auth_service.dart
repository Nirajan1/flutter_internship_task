import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Utils/http_client.dart';
import 'package:online_store/Utils/local_storage.dart';

class RemoteLoginService {
  static Future logIn(var data) async {
    try {
      var response = await HttpClient.client.post(
        Uri.parse("https://fakestoreapi.com/auth/login"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        await LocalStorage.storeUserToken(
          response.body,
          data['username'],
          data['password'],
        );
        LocalStorage.getUserToken();
        Get.offAllNamed('/home');
      } else if (response.statusCode == 401) {
        Get.defaultDialog(
          backgroundColor: Colors.red.shade50,
          title: "Error",
          content: const Text('Invalid username or password'),
          cancel: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("OK"),
          ),
        );
      }
    } catch (exception) {
      debugPrint('ErrorL login service $exception');
    }
  }
}
