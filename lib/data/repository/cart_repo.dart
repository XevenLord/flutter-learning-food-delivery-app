import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];
    /*
      convert objects to strings because sharedpreferences only accepts strings
    */
    cartList.forEach((element) => cart.add(jsonEncode(element)));

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList" + carts.toString());
    }

    List<CartModel> cartList = [];

    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    return cartHistory
        .map<CartModel>((history) => CartModel.fromJson(jsonDecode(history)))
        .toList();
  }

  void addToCartHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    cart.forEach((element) {
      cartHistory.add(element);
      print("element: " + element);
    });
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    print(
        "length of history list is " + getCartHistoryList().length.toString());
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
