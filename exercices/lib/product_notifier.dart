import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:formation_flutter/model/product.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ProductNotifier extends ChangeNotifier {
  Product? _product;
  Product? get product => _product;
  Future<void> loadProduct() async{
    Dio dio = Dio();
    Response<dynamic> response = await dio.get('https://api.formation-flutter.fr/v2/getProduct?barcode=5000159484695');
    Map<String, dynamic> json = jsonDecode(response.data);
    final apiProduct = Product.fromJSON(json);
    notifyListeners();
  }
  ProductNotifier(){
    loadProduct();
  }
}