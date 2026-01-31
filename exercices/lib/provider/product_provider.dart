import 'package:flutter/widgets.dart';
import '../model/product.dart';

class ProductProvider extends InheritedWidget {
  final Product product;

  const ProductProvider({
    super.key,
    required this.product,
    required super.child,
  });

  static ProductProvider? of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ProductProvider>();
    return provider;
  }

  @override
  bool updateShouldNotify(ProductProvider oldWidget) {
    return product != oldWidget.product;
  }
}