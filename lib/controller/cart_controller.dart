import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/popular_product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({
    required this.cartRepo,
  });
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

// only for storage and sharedpreferences
  List<CartModel> storageItems = [];

// cart functionality
  void addItem(ProductModel product, int quantity) {
    // print("length of the item is" + _items.length.toString());
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          quantity: value.quantity! + quantity,
          img: value.img,
          isExist: true,
          time: DateTime.now().toString(),
          // new changes made for the integration of cart page
          // making the quantity of the cart page dynamically
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity >= 0) {
        _items.putIfAbsent(product.id!, () {
          // print("adding item to the cart " +
          //     product.id!.toString() +
          //     " quantity " +
          //     quantity.toString());
          _items.forEach((key, value) {
            // print("Quantity is " + value.quantity.toString());
          });
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            quantity: quantity,
            img: product.img,
            isExist: true,
            time: DateTime.now().toString(),
            // new changes made for the integration of cart page
            // making the quantity of the cart page dynamically
            product: product,
          );
        });
      } else {
        Get.snackbar(
          "item count",
          "you should at least add an item in the cart !",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }

    cartRepo.addToCartList(getItems);
    // for updating the quantity value
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

// to list the item selected on the cart
  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

// calculating the total price and total quantity on the cart
  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  //  for storage and sharedpreferences
  List<CartModel> getCartData() {
    // setCart to List
    setCart = cartRepo.getCartList();

    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;

    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistory();
    // to clear item when added to cart
    clear();
  }

  void clear() {
    _items = {};
    update();
  }
}
