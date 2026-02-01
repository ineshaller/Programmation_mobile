import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:formation_flutter/model/product.dart';

class ProductNotifier extends ChangeNotifier {
  Product? _product;
  Product? get product => _product;
  void loadProduct(){
    _product = generateProduct();
    notifyListeners();
  }
  ProductNotifier(){
    loadProduct();
  }
}