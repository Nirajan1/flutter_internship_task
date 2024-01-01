import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Utils/app_color.dart';
import 'package:online_store/Utils/app_size.dart';

class BuyNowButton extends StatelessWidget {
  const BuyNowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.hPadding),
      child: SizedBox(
        height: 50,
        width: Get.size.width * .3,
        child: MaterialButton(
          elevation: .3,
          color: AppColor.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(9.0),
            ),
          ),
          onPressed: () {},
          child: const Text(
            'Buy Now',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
