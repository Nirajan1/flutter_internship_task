import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Services/auth_service.dart';
import 'package:online_store/Utils/app_color.dart';
import 'package:online_store/Utils/local_storage.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);
  void splashScreenBuild(BuildContext context) {
    LocalStorage.getUserToken().then((_) {
      if (LocalStorage.accessToken != null) {
        Timer(const Duration(seconds: 4), () async {
          Map data = {
            'username': LocalStorage.userName,
            'password': LocalStorage.passWord,
          };
          await RemoteLoginService.logIn(data);
        });
      } else {
        Timer(const Duration(seconds: 4), () {
          Get.offAllNamed('/login');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    splashScreenBuild(context);
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: AppColor.backgroundColor,
                radius: 60,
                child: Text(
                  'OnlineStore',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
              CircularProgressIndicator.adaptive(),
            ],
          ),
        ),
      ),
    );
  }
}
