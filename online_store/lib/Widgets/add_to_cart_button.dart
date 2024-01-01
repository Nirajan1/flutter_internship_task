import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/Utils/app_color.dart';
import 'package:online_store/Utils/app_size.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.hPadding),
      child: SizedBox(
        height: 50,
        width: Get.size.width * .33,
        child: MaterialButton(
          elevation: .3,
          color: AppColor.ionColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(9.0),
            ),
          ),
          onPressed: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_shopping_cart_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 6.0),
              Text(
                'Add to cart',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
