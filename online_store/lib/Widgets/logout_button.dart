import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Utils/app_color.dart';
import 'package:online_store/Utils/local_storage.dart';
import 'package:online_store/Widgets/main_button.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Get.defaultDialog(
              barrierDismissible: false,
              title: 'Logout'.tr,
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              content: Text(
                'Are you sure you want to log out?'.tr,
              ),
              cancel: MainButton(
                  title: 'No'.tr,
                  color: Colors.grey.shade100,
                  onPressedCallback: () {
                    Get.back();
                  }),
              confirm: MainButton(
                title: 'Yes'.tr,
                color: AppColor.primaryColor,
                textColor: Colors.white,
                onPressedCallback: () async {
                  await LocalStorage.logout();
                  Get.offAllNamed('/login');
                },
              ));
        },
        icon: const Icon(Icons.logout_outlined));
  }
}
