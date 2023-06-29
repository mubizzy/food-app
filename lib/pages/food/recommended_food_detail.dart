// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  RecommendedFoodDetail({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductContoller>().recommendedProductList[pageId];
    Get.find<PopularProductContoller>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(icon: Icons.clear)),
                  //
                  //AppIcon(icon: Icons.shopping_cart_checkout_outlined),
                  GetBuilder<PopularProductContoller>(builder: (controller) {
                    return Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductContoller>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductContoller>().totalItems >= 1
                            ? Positioned(
                                right: 5,
                                top: 3,
                                child: BigText(
                                  text: Get.find<PopularProductContoller>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container()
                      ],
                    );
                  })
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  // margin: EdgeInsets.only(
                  //     left: Dimension.width20, right: Dimension.width20),
                  child: Center(child: BigText(size: 20, text: product.name!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimension.radius20),
                          topRight: Radius.circular(Dimension.radius20)),
                      color: Colors.white),
                ),
              ),
              expandedHeight: 300,
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
              children: [ExpandableText(text: product.description!)],
            ))
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductContoller>(builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimension.width20 * 2.5,
                    right: Dimension.width20 * 2.5,
                    top: Dimension.height10,
                    bottom: Dimension.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                          iconSize: Dimension.iconSize24,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          icon: Icons.remove),
                    ),
                    BigText(
                      text:
                          "\$ ${product.price!}   X  ${controller.inCartItems}",
                      color: AppColors.mainColor,
                      size: Dimension.font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                          iconSize: Dimension.iconSize24,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          icon: Icons.add),
                    ),
                  ],
                ),
              ),
              Container(
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
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          )),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(product);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimension.height20,
                              bottom: Dimension.height20,
                              left: Dimension.width20,
                              right: Dimension.width20),
                          child: BigText(
                              text: "\$${product.price}| Add to cart",
                              color: Colors.white),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius20),
                              color: AppColors.mainColor),
                        ),
                      )
                    ],
                  ))
            ],
          );
        }));
  }
}
