import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:wicca_store_3/Services/prefrence_servce.dart';
import 'package:wicca_store_3/main.dart';
import 'package:wicca_store_3/models/product.model.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Product>? favouriteProducts;
  final _preferenceKey = 'favouriteProducts';
  final BuildContext? currentContext = navigatorKey.currentContext;
  SimpleFontelicoProgressDialog? _dialog;

  FavouriteProvider() {
    if (currentContext != null) {
      _dialog = SimpleFontelicoProgressDialog(context: currentContext!);
    }
  }

  bool isFavourite(int productId) =>
      (favouriteProducts?.any((e) => e.id == productId) ?? false);

  Future<void> getFavoriteProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    if (PreferencesService.preferences?.getStringList(_preferenceKey) == null)
      return;
    var encodedList =
        PreferencesService.preferences?.getStringList(_preferenceKey);

    var decodedList = encodedList?.map((e) => jsonDecode(e)).toList() ?? [];
    favouriteProducts = decodedList.map((e) => Product.fromJson(e)).toList();
    notifyListeners();
  }

  void addProductToFavourites(Product product) async {
    if (_dialog != null) {
      _dialog!.show(
          message: 'Loading...',
          type: SimpleFontelicoProgressDialogType.phoenix);
    }

    var encodedList =
        PreferencesService.preferences?.getStringList(_preferenceKey) ?? [];
    var encodedProduct = jsonEncode(product.toJson());
    encodedList.add(encodedProduct);
    await PreferencesService.preferences
        ?.setStringList(_preferenceKey, encodedList);
    await getFavoriteProducts();

    if (_dialog != null) {
      _dialog!.hide();
    }
  }

  void removeProductFromFavourites(int id) async {
    if (_dialog != null) {
      _dialog!.show(
          message: 'Loading...',
          type: SimpleFontelicoProgressDialogType.phoenix);
    }

    var decodedList = PreferencesService.preferences
        ?.getStringList(_preferenceKey)
        ?.map((e) => jsonDecode(e))
        .toList();

    decodedList?.removeWhere((element) => element['id'] == id);

    var encodedList = decodedList?.map((e) => jsonEncode(e)).toList();
    await PreferencesService.preferences
        ?.setStringList(_preferenceKey, encodedList ?? []);

    await getFavoriteProducts();

    if (_dialog != null) {
      _dialog!.hide();
    }
  }
}
