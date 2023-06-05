class CartModel {
  int? id;
  String? name;
  int? quantity;
  int? price;
  bool? isExist;
  String? img;
  String? time;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.img,
    this.isExist,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    isExist = json['isExist'];
    img = json['img'];
    time = json['time'];
  }
}
