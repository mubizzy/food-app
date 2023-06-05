import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/popular_product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductContoller extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductContoller({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      // print("got products");
      _popularProductList = [];
      _popularProductList
          .addAll(Product.fromJson(response.body).products as Iterable);
      // print(_popularProductList);
      _isLoaded = true;
      update();
    } else {}
  }

// beginning of shopping cart
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      // print("increment" + _quantity.toString());
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        "item count",
        "you can't reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if (quantity > 20) {
      Get.snackbar(
        "item count",
        "you can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  // for checking the status of the number of the cart
  void initProduct() {
    _quantity = 0;
    _inCartItems = 0;
    // if exist
    // get from storage _inCartItems=3
  }
}
