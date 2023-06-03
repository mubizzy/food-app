import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/popular_product_model.dart';
import 'package:get/get.dart';

class PopularProductContoller extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductContoller({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList
          .addAll(Product.fromJson(response.body).products as Iterable);
      print(_popularProductList);
      update();
    } else {}
  }
}
