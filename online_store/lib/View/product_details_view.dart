import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:online_store/Controller/single_product_controller.dart';
import 'package:online_store/Theme/custom_theme.dart';
import 'package:online_store/Utils/app_color.dart';
import 'package:online_store/Utils/app_size.dart';
import 'package:online_store/Widgets/buy_now_button.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var singleProductController = Get.find<SingleProductController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
        ),
        bottomNavigationBar: Container(
          height: 55,
          decoration: const BoxDecoration(color: Colors.white),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BuyNowButton(),
            ],
          ),
        ),
        body: Obx(
          () {
            if (singleProductController.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* product image section
                    SizedBox(
                      height: Get.size.height * .53,
                      width: Get.size.width,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(9.0),
                              bottomRight: Radius.circular(9.0),
                            )),
                        child: Image.network(
                          '${singleProductController.productDetails.value.image}',
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return CircularProgressIndicator.adaptive(
                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),

                    //*product details section card
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSize.vPadding, horizontal: AppSize.hPadding),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ?product title
                              Text(
                                "${singleProductController.productDetails.value.title}",
                                style: myTheme.textTheme.titleSmall,
                              ),
                              const SizedBox(height: 10),
                              //? product price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Rs ',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: '${singleProductController.productDetails.value.price}',
                                            style: const TextStyle(
                                              fontSize: 19,
                                            )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.favorite_outline_outlined,
                                          color: Colors.black54,
                                          size: 19,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '80',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 10),
                              const SizedBox(height: 10),
                              // ? product rating
                              Row(
                                children: [
                                  const Icon(Icons.star, color: AppColor.ionColor, size: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    child: Text("${singleProductController.productDetails.value.rating!.rate}/5"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              //? product banner
                              Container(
                                height: 76,
                                width: Get.size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.0),
                                  color: Colors.blue.shade100,
                                ),
                                child: ListTile(
                                  textColor: Colors.blue.shade600,
                                  title: RichText(
                                    text: TextSpan(
                                      text: 'Free Deliver  ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue.shade600,
                                      ),
                                      children: const [
                                        TextSpan(
                                            text: ' 6 jan - 9 jan',
                                            style: TextStyle(
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                  ),
                                  subtitle: const Text(
                                    'On minimum spend of Rs. 300 on same store',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //*product rating section cart
                    Container(
                      width: Get.size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ratings & Reviews', style: myTheme.textTheme.headlineMedium),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${singleProductController.productDetails.value.rating!.rate}",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  RatingBar.builder(
                                    initialRating: singleProductController.productDetails.value.rating!.rate!.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 24,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 2,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 6.0),
                                            child: SizedBox(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt_rounded,
                                                    color: Colors.black54,
                                                    size: 18,
                                                  ),
                                                  SizedBox(width: 2),
                                                  Text(
                                                    "Photos(10)",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.black54,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 6.0),
                                            child: Text(
                                              "ViewAll(90)",
                                              style: TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.black54,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.vPadding,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(),
                    ),
                    //*product details section
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSize.vPadding, horizontal: AppSize.hPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product Details', style: myTheme.textTheme.headlineMedium),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            "${singleProductController.productDetails.value.description}",
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
