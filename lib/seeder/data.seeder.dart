import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wicca_store_3/models/ads_model.dart';
import 'package:wicca_store_3/models/category.model.dart';
import 'package:wicca_store_3/models/product.model.dart';

class DataSeeder {
  static Map _data = {};

  static List<Product> products = [];
  static List<CategoryData> categories = [];
  static List<Ads> ads = [];

  static Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 5));
    var response = await rootBundle.loadString('assets/data_1/data.json');
    _data = jsonDecode(response);
    products =
        (_data['products'] as List).map((e) => Product.fromJson(e)).toList();

    categories = (_data['categories'] as List)
        .map((e) => CategoryData.fromJson(e))
        .toList();
    ads = (_data['ads'] as List).map((e) => Ads.fromJson(e)).toList();
  }
}
