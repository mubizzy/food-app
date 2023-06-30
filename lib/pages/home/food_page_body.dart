import 'package:flutter/material.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';
import 'package:food_delivery/models/popular_product_model.dart';
// import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider Section
        GetBuilder<PopularProductContoller>(builder: (popularPoducts) {
          return popularPoducts.isLoaded
              ? Container(
                  height: 320,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularPoducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularPoducts.popularProductList[position]);
                      }))
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),

        // Container(
        //     height: 320,
        //     child: PageView.builder(
        //         controller: pageController,
        //         itemCount: 5,
        //         itemBuilder: (context, position) {
        //           return _buildPageItem(position);
        //         })),

        SizedBox(
          height: 20,
        ),

        // dots
        GetBuilder<PopularProductContoller>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue.toInt(),
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: Size.square(9.0),
              activeSize: Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: 10,
        ),

        // popular text
        Container(
          margin: EdgeInsets.only(left: Dimension.width30),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(text: "Recommended"),
            SizedBox(
              width: Dimension.width10,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 3),
              child: BigText(text: ".", color: Colors.black26),
            ),
            SizedBox(
              width: Dimension.width10,
            ),
            Container(
              child: SmallText(text: "Food pairing"),
            )
          ]),
        ),
        //  List of food
        GetBuilder<RecommendedProductContoller>(builder: (recommendedPoducts) {
          return recommendedPoducts.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedPoducts.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimension.width20,
                            right: Dimension.width20,
                            bottom: Dimension.height10),
                        child: Row(children: [
                          // image section
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimension.radius20),
                                color: Colors.white30,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        recommendedPoducts
                                            .recommendedProductList[index]
                                            .img!))),
                          ),

                          // Text Container
                          Expanded(
                            child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                            Radius.circular(Dimension.radius20),
                                        bottomRight: Radius.circular(
                                            Dimension.radius20)),
                                    color: Colors.white),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimension.width10,
                                        right: Dimension.width10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                            text: recommendedPoducts
                                                .recommendedProductList[index]
                                                .name!),
                                        SmallText(
                                            text:
                                                "with chines characteristics"),
                                        Row(
                                          children: [
                                            IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1,
                                            ),
                                            SizedBox(width: 10),
                                            IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.7km",
                                              iconColor: AppColors.mainColor,
                                            ),
                                            SizedBox(width: 10),
                                            IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: "32min",
                                              iconColor: AppColors.iconColor2,
                                            )
                                          ],
                                        )
                                      ],
                                    ))),
                          )
                        ]),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(
    int index,
    ProductModel popularProductList,
  ) {
    // position changes in a nice way
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - currScale) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: 220,
              margin: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: index.isEven ? Color(0xFFffd379) : Color((0xFF89dad0)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          popularProductList.img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 130,
              margin: EdgeInsets.only(
                left: 30,
                right: 30,
                // bottom: 20,
                top: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color(0xFFe8e8e8), offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Container(
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: popularProductList.name!),
                          SizedBox(height: 10),
                          Row(children: [
                            Wrap(
                                children: List.generate(
                                    5,
                                    (index) => Icon(Icons.star,
                                        color: AppColors.mainColor))),
                            SizedBox(
                              width: 10,
                            ),
                            SmallText(text: "4.5"),
                            SizedBox(
                              width: 10,
                            ),
                            SmallText(text: "comments")
                          ]),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              IconAndTextWidget(
                                icon: Icons.circle_sharp,
                                text: "Normal",
                                iconColor: AppColors.iconColor1,
                              ),
                              SizedBox(width: 10),
                              IconAndTextWidget(
                                icon: Icons.location_on,
                                text: "1.7km",
                                iconColor: AppColors.mainColor,
                              ),
                              SizedBox(width: 10),
                              IconAndTextWidget(
                                icon: Icons.access_time_rounded,
                                text: "32min",
                                iconColor: AppColors.iconColor2,
                              )
                            ],
                          )
                        ],
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
