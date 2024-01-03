import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Services/auth_service.dart';
import 'package:online_store/Utils/app_color.dart';
import 'package:online_store/Utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  checkAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await LocalStorage.getUserToken();
    var token = LocalStorage.accessToken;
    var langCode = preferences.getString('langCode');
    var countryCode = preferences.getString('countryCode');
    if (langCode != null && countryCode != null) {
      Get.updateLocale(Locale(langCode, countryCode));
    }
    if (token != null) {
      Map data = {
        'username': LocalStorage.userName,
        'password': LocalStorage.passWord,
      };
      await RemoteLoginService.logIn(data);
    } else if (token == null && langCode != null && countryCode != null) {
      Get.updateLocale(Locale(langCode, countryCode));
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAllNamed('/login');
      });
    } else {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAllNamed('/login');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    // splashScreenBuild(context);
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
