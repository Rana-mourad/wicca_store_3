import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:wicca_store_3/Services/prefrence_servce.dart';
import 'package:wicca_store_3/main.dart';
import 'package:wicca_store_3/models/order_item.dart';
import 'package:wicca_store_3/models/product.model.dart';
import 'package:wicca_store_3/views/homepage.dart';

class CartProvider extends ChangeNotifier {
  List<OrderItem>? cartItems;
  final _preferenceKey = 'cartItems';
  int itemQuantity = 1;
  final SimpleFontelicoProgressDialog _dialog =
      SimpleFontelicoProgressDialog(context: navigatorKey.currentContext!);

  void removeItemFromCart(int productId) async {
    _dialog.show(
        message: 'Loading...', type: SimpleFontelicoProgressDialogType.phoenix);

    var encodedList =
        PreferencesService.preferences?.getStringList(_preferenceKey);

    encodedList?.removeWhere(
        (encodedElement) => jsonDecode(encodedElement)['uId'] == productId);

    await PreferencesService.preferences
        ?.setStringList(_preferenceKey, encodedList ?? []);

    await getCartProducts();

    _dialog.hide();
  }

  void onChangeItemQuantity(int productId,
      {bool decrease = false, bool fromCart = false}) async {
    _dialog.show(
        message: 'Loading...', type: SimpleFontelicoProgressDialogType.phoenix);

    if (fromCart) {
      getItemQuantity(productId);
    }

    if (decrease == true) {
      if (itemQuantity == 1) {
        _dialog.hide();
        return;
      }

      itemQuantity--;
    } else {
      itemQuantity++;
    }

    if (!checkItemInCart(productId)) {
      notifyListeners();
      _dialog.hide();
      return;
    }
    var encodedList =
        PreferencesService.preferences?.getStringList(_preferenceKey);
    var orderItemList =
        encodedList?.map((e) => OrderItem.fromJson(jsonDecode(e))).toList();

    var updatedItem =
        orderItemList?.firstWhere((element) => element.uId == productId);

    orderItemList?.removeWhere((element) => element.uId == productId);

    updatedItem?.quantity = itemQuantity;
    updatedItem?.price =
        ((updatedItem.product?.price ?? 0) * itemQuantity).toDouble();

    orderItemList?.add(updatedItem!);

    var updateList = orderItemList?.map((e) => jsonEncode(e.toJson())).toList();

    await PreferencesService.preferences
        ?.setStringList(_preferenceKey, updateList ?? []);

    getItemQuantity(productId);
    await getCartProducts();

    _dialog.hide();
  }

  void getItemQuantity(int productId) {
    var encodedList =
        PreferencesService.preferences?.getStringList(_preferenceKey);

    var decodedList = encodedList?.map((e) => jsonDecode(e)).toList();

    var item = decodedList?.firstWhere((element) => element['uId'] == productId,
        orElse: () => null);

    itemQuantity = (item != null) ? item['quantity'] : 1;
    notifyListeners();
  }

  bool checkItemInCart(int productId) {
    var encodedList =
        PreferencesService.preferences?.getStringList(_preferenceKey);

    var decodedList = encodedList?.map((e) => jsonDecode(e)).toList();

    return decodedList?.any((element) => element['uId'] == productId) ?? false;
  }

  void addProductToCart(Product product) async {
    _dialog.show(
        message: 'Loading...', type: SimpleFontelicoProgressDialogType.phoenix);

    var encodedList =
        PreferencesService.preferences?.getStringList(_preferenceKey) ?? [];
    var orderItem = OrderItem();
    orderItem.uId = product.id;
    orderItem.quantity = itemQuantity;
    orderItem.product = product;
    orderItem.price = (itemQuantity * (product.price ?? 0)).toDouble();
    var encodeOrderItem = jsonEncode(orderItem.toJson());
    encodedList.add(encodeOrderItem);

    await PreferencesService.preferences
        ?.setStringList(_preferenceKey, encodedList);
    await getCartProducts();
    _dialog.hide();
  }

  double getTotalCartValue() {
    double totalValue = 0;
    for (var item in cartItems ?? []) {
      totalValue += (item.price ?? 0);
    }

    return totalValue;
  }

  Future<void> getCartProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    if (PreferencesService.preferences?.getStringList(_preferenceKey) == null)
      return;

    var encodedList = PreferencesService.preferences
        ?.getStringList(_preferenceKey)
        ?.map((e) => jsonDecode(e))
        .toList();

    cartItems = encodedList?.map((e) => OrderItem.fromJson(e)).toList();
    cartItems?.sort((a, b) => a.uId?.compareTo(b.uId ?? 0) ?? 0);
    notifyListeners();
  }

  void onBuyNowClicked() async {
    _dialog.show(
        message: 'Loading...', type: SimpleFontelicoProgressDialogType.phoenix);

    try {
      // ignore: unused_local_variable
      var encodedList =
          PreferencesService.preferences?.getStringList(_preferenceKey) ?? [];
      // ignore: unused_local_variable
      var totalItems = 0;
      // ignore: unused_local_variable
      var totalPrice = 0.0;

      for (var item in cartItems!) {
        totalItems += (item.quantity ?? 0);
        totalPrice += (item.price ?? 0);
      }
      await PreferencesService.preferences?.setStringList(_preferenceKey, []);
      await getCartProducts();
      _dialog.hide();
      Alert(
          context: navigatorKey.currentContext!,
          title: "Order Done Successfully",
          type: AlertType.success,
          buttons: [
            DialogButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    navigatorKey.currentContext!,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false),
                child: const Text('Ok'))
          ]).show();
    } catch (e) {
      _dialog.hide();

      Alert(
          context: navigatorKey.currentContext!,
          title: "Error In Creating Order",
          desc: 'error : ${e.toString()}',
          type: AlertType.error,
          buttons: [
            DialogButton(
                onPressed: () => Navigator.pop(navigatorKey.currentContext!),
                child: const Text('Ok'))
          ]).show();
    }
  }
}
