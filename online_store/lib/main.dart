import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_store/Bindings/controller_binding.dart';
import 'package:online_store/Theme/custom_theme.dart';
import 'package:online_store/Utils/local_string.dart';
import 'package:online_store/View/auth/splash_screen_view.dart';
import 'package:online_store/View/auth/user_login_view.dart';
import 'package:online_store/View/cart_list_view.dart';
import 'package:online_store/View/home_view.dart';
import 'package:online_store/View/product_details_view.dart';
import 'package:online_store/View/search_view.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp], //!set orientation to portrait
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: myTheme,
      translations: LocaleStrings(),
      home: const SplashScreenView(),
      initialBinding: ControllerBinding(),
      //* Route using GetX get page
      getPages: [
        GetPage(name: '/SplashScreenView', page: () => const SplashScreenView()),
        GetPage(name: '/home', page: () => const HomeView()),
        GetPage(name: '/login', page: () => const LoginPageView()),
        GetPage(name: '/SearchPage', page: () => const SearchPageView()),
        GetPage(name: '/ProductDetailPage', page: () => const ProductDetailView()),
        GetPage(name: '/CartListViewPage', page: () => const CartListViewPage()),
      ],
    );
  }
}
