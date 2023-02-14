import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];
    /*
      convert objects to strings because sharedpreferences only accepts strings
    */

    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList("Cart-list", cart);
    print(sharedPreferences.getStringList("Cart-list"));
  }
}
