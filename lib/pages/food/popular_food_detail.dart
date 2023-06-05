import 'package:flutter/material.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductContoller>().popularProductList[pageId];
    // print("page is id" + pageId.toString());

    // print("product name is " + product.name.toString());
    Get.find<PopularProductContoller>().initProduct();
    return Scaffold(
        body: Stack(
          children: [
            // background image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimension.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!))),
              ),
            ),
            // icon widgets
            Positioned(
                left: Dimension.width20,
                right: Dimension.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(() => MainFoodPage());
                        },
                        child: AppIcon(icon: Icons.arrow_back_ios)),
                    AppIcon(icon: Icons.shopping_cart_outlined)
                  ],
                )),
            // introduction of food
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimension.popularFoodImgSize - 20,
                child: Container(
                    padding: EdgeInsets.only(
                        left: Dimension.width20,
                        right: Dimension.width20,
                        top: Dimension.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimension.radius20),
                            topLeft: Radius.circular(Dimension.radius20)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppColumn(
                          text: product.name!,
                        ),
                        SizedBox(
                          height: Dimension.height20,
                        ),
                        BigText(text: "Introduce"),
                        SizedBox(
                          height: Dimension.height20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ExpandableText(text: product.description!),
                          ),
                        )
                      ],
                    )))

            // expandable text widget
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductContoller>(
          builder: (popularPoduct) {
            return Container(
                padding: EdgeInsets.only(
                    top: Dimension.height30,
                    bottom: Dimension.height30,
                    left: Dimension.width20,
                    right: Dimension.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimension.radius20 * 20)),
                    color: AppColors.buttonBackgroundColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimension.height20,
                          bottom: Dimension.height20,
                          left: Dimension.width20,
                          right: Dimension.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20),
                          color: Colors.white),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                popularPoduct.setQuantity(false);
                              },
                              child: Icon(Icons.remove,
                                  color: AppColors.signColor)),
                          SizedBox(
                            width: Dimension.width10,
                          ),
                          BigText(text: popularPoduct.quantity.toString()),
                          SizedBox(
                            width: Dimension.width10 / 2,
                          ),
                          GestureDetector(
                              onTap: () {
                                popularPoduct.setQuantity(true);
                              },
                              child:
                                  Icon(Icons.add, color: AppColors.signColor))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimension.height20,
                          bottom: Dimension.height20,
                          left: Dimension.width20,
                          right: Dimension.width20),
                      child: BigText(
                          text: "\$ ${product.price!} | Add to cart",
                          color: Colors.white),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20),
                          color: AppColors.mainColor),
                    )
                  ],
                ));
          },
        ));
  }
}
