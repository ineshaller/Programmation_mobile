import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:formation_flutter/model/product.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ProductNotifier extends ChangeNotifier {
  Product? _product;
  Product? get product => _product;
  Future<void> loadProduct() async {
    Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://api.formation-flutter.fr/v2/getProduct?barcode=5000159484695',
      );
      final data = response.data;
      final api = data['response'] as Map<String, dynamic>;

      final productJson = <String, dynamic>{
        'barcode': api['barcode'],
        'name': api['name'],
        'altName': api['altName'],
        'picture': api['pictures']?['product'],
        'quantity': api['quantity'],
        'brands': api['brands'],
        'manufacturingCountries': api['manufacturingCountries'],
        'nutriScore': api['nutriScore']?.toString(),
        'nutriScoreLevels': api['nutriScoreLevels'],
        'nutritionFacts': api['nutritionFacts'],
        'novaScore': api['novaScore'].toString(),
        'greenScore': api['greenScore'].toString(),
        'ingredients': api['ingredients']?['list'],
        'ingredientsWithAllergens': api['ingredients']?['withAllergens'].toString(),
        'traces': api['traces']?['list'],
        'allergens': api['allergens']?['list'],
        'additives': api['additives'],
        'nutrientLevels': null,
        'ingredientsFromPalmOil': api['ingredients']?['containsPalmOil'],
        'containsPalmOil': api['containsPalmOil']?.toString(),
        'isVegan': api['analysis']?['vegan']?.toString(),
        'isVegetarian': api['analysis']?['vegetarian']?.toString(),
      };
      _product = Product.fromJSON(productJson);
    } catch (e) {
      debugPrint('Erreur loadProduct: $e');
    }

    notifyListeners();
  }

  ProductNotifier() {
    loadProduct();
  }
}
