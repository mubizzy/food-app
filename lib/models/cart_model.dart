import 'package:food_delivery/models/popular_product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? quantity;
  int? price;
  bool? isExist;
  String? img;
  String? time;
  // new changes made fr the integration of cart page
  ProductModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.img,
    this.isExist,
    this.time,
    // new changes made for the integration of cart page
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    isExist = json['isExist'];
    img = json['img'];
    time = json['time'];
    // making the quantity of the cart page dynamically
    product = ProductModel.fromJson(json['product']);
  }

  // special decoding for cart history
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "quantity": this.quantity,
      "price": this.price,
      "isExist": this.isExist,
      "img": this.img,
      "time": this.time,
      "product": this.product!.toJson(),
    };
  }
}
