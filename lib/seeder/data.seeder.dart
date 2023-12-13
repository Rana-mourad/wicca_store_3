import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wicca_store_3/models/category.model.dart';
import 'package:wicca_store_3/models/product.model.dart';

class DataSeeder {
  static Map<String, dynamic> _data = {};
  static List<Product> products = [];
  static List<CategoryData> categories = [];

  static Future<void> loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 5));

      var response = await rootBundle.loadString('assets/data/data.json');
      _data = jsonDecode(response);
      _parseProducts();
      _parseCategories();
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  static void _parseProducts() {
    products =
        (_data['products'] as List).map((e) => Product.fromJson(e)).toList();
  }

  static void _parseCategories() {
    categories = (_data['categories'] as List)
        .map((e) => CategoryData.fromJson(e))
        .toList();
  }
}
