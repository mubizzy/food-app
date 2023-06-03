import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

Future<void> init() async {
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: 'http://mvs.bslmeiyu.com'));

  // Repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  // controllers
  Get.lazyPut(() => PopularProductContoller(popularProductRepo: Get.find()));
}
