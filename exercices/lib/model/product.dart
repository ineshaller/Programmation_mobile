// ignore_for_file: constant_identifier_names
import 'dart:convert';

class ApiProduct {
  final String barcode;
  final String? name;
  final String? altName;
  final String? picture;
  final String? quantity;

  final List<String>? brands;
  final List<String>? manufacturingCountries;

  final String? nutriScore;
  final dynamic nutriScoreLevels;
  final String? novaScore;
  final String? greenScore;

  final List<String>? ingredients;
  final String? ingredientsWithAllergens;
  final List<String>? traces;
  final List<String>? allergens;
  final Map<String, String>? additives;

  final dynamic nutrientLevels;
  final dynamic nutritionFacts;

  final bool? ingredientsFromPalmOil;

  final dynamic containsPalmOil;
  final String? isVegan;
  final String? isVegetarian;

  ApiProduct({
    required this.barcode,
    this.name,
    this.altName,
    this.picture,
    this.quantity,
    this.brands,
    this.manufacturingCountries,
    this.nutriScore,
    this.nutriScoreLevels,
    this.novaScore,
    this.greenScore,
    this.ingredients,
    this.ingredientsWithAllergens,
    this.traces,
    this.allergens,
    this.additives,
    this.nutrientLevels,
    this.nutritionFacts,
    this.ingredientsFromPalmOil,
    this.containsPalmOil,
    this.isVegan,
    this.isVegetarian,
  });

  factory ApiProduct.fromJSON(Map<String, dynamic> json) {
    List<String> toStringList(dynamic valeur) {
      if (valeur is List) return valeur.map((e) => e.toString()).toList();
      return [];
    }

    Map<String, String>? toStringMap(dynamic valeur) {
      if (valeur is Map) {
        return valeur.map(
          (key, value) => MapEntry(key.toString(), value.toString()),
        );
      }
      return null;
    }

    bool? toBool(dynamic valeur) {
      if (valeur is bool) return valeur;
      if (valeur == null) return null;
      final s = valeur.toString().toLowerCase();
      if (s == 'true' || s == '1') return true;
      if (s == 'false' || s == '0') return false;
      return null;
    }

    return ApiProduct(
      barcode: json['barcode']?.toString() ?? '',
      name: json['name']?.toString(),
      altName: json['altName']?.toString(),
      picture: json['picture']?.toString(),
      quantity: json['quantity']?.toString(),
      brands: json['brands'] != null ? List<String>.from(json['brands']) : null,
      manufacturingCountries: json['manufacturingCountries'] != null
          ? List<String>.from(json['manufacturingCountries'])
          : null,
      nutriScore: json['nutriScore']?.toString(),
      nutriScoreLevels: json['nutriScoreLevels'],
      novaScore: json['novaScore']?.toString(),
      greenScore: json['greenScore']?.toString(),
      ingredients: json['ingredients'],
      ingredientsWithAllergens: json['ingredientsWithAllergens']?.toString(),
      traces: toStringList(json['traces']),
      allergens: toStringList(json['allergens']),
      additives: toStringMap(json['additives']),
      nutrientLevels: json['nutrientLevels'],
      ingredientsFromPalmOil: toBool(json['ingredientsFromPalmOil']),
      containsPalmOil: toBool(json['containsPalmOil']),
      isVegan: json['isVegan']?.toString(),
      isVegetarian: json['isVegetarian']?.toString(),
    );
  }
}

class Product {
  final String barcode;
  final String? name;
  final String? altName;
  final String? picture;
  final String? quantity;
  final List<String>? brands;
  final List<String>? manufacturingCountries;
  final ProductNutriScore? nutriScore;
  final ProductNutriScoreLevels? nutriScoreLevels;
  final ProductNovaScore? novaScore;
  final ProductGreenScore? greenScore;
  final List<String>? ingredients;

  // Eg: "Sucre, <span class=\"allergen\">gluten de blé</span>"
  final String? ingredientsWithAllergens;
  final List<String>? traces;
  final List<String>? allergens;
  final Map<String, String>? additives;
  final NutrientLevels? nutrientLevels;
  final NutritionFacts? nutritionFacts;
  final bool? ingredientsFromPalmOil;
  final ProductAnalysis? containsPalmOil;
  final ProductAnalysis? isVegan;
  final ProductAnalysis? isVegetarian;

  Product({
    required this.barcode,
    this.name,
    this.altName,
    this.picture,
    this.quantity,
    this.brands,
    this.manufacturingCountries,
    this.nutriScore,
    this.nutriScoreLevels,
    this.novaScore,
    this.greenScore,
    this.ingredients,
    this.ingredientsWithAllergens,
    this.traces,
    this.allergens,
    this.additives,
    this.nutrientLevels,
    this.nutritionFacts,
    this.ingredientsFromPalmOil,
    this.containsPalmOil,
    this.isVegan,
    this.isVegetarian,
  });

  factory Product.fromApi(ApiProduct apiProduct) {
    return Product(
      barcode: apiProduct.barcode,
      name: apiProduct.name,
      altName: apiProduct.altName,
      picture: apiProduct.picture,
      quantity: apiProduct.quantity,
      brands: apiProduct.brands,
      manufacturingCountries: apiProduct.manufacturingCountries,
      nutriScore: _parseNutriScore(apiProduct.nutriScore),
      nutriScoreLevels: _parseNutriScoreLevels(apiProduct.nutriScoreLevels),
      nutritionFacts: _parseNutritionFacts(apiProduct.nutritionFacts),
      novaScore: _parseNovaScore(apiProduct.novaScore),
      greenScore: _parseGreenScore(apiProduct.greenScore),
      ingredients: apiProduct.ingredients,
      ingredientsWithAllergens: apiProduct.ingredientsWithAllergens,
      traces: apiProduct.traces,
      allergens: apiProduct.allergens,
      additives: apiProduct.additives,
      nutrientLevels: null,
      ingredientsFromPalmOil: apiProduct.ingredientsFromPalmOil,
      containsPalmOil: ProductAnalysis.fromString(
        apiProduct.containsPalmOil?.toString(),
      ),
      isVegan: ProductAnalysis.fromString(apiProduct.isVegan),
      isVegetarian: ProductAnalysis.fromString(apiProduct.isVegetarian),
    );
  }

  Product.fromJSON(Map<String, dynamic> json)
    : barcode = json['barcode'],
      name = json['name'],
      altName = json['altName'],
      picture = json['picture'],
      quantity = json['quantity'],
      brands = json['brands'] != null
          ? List<String>.from(json['brands'])
          : null,
      manufacturingCountries = json['manufacturingCountries'] != null
          ? List<String>.from(json['manufacturingCountries'])
          : null,
      nutriScore = _parseNutriScore(json['nutriScore']),
      nutriScoreLevels = _parseNutriScoreLevels(json['nutriScoreLevels']),
      nutritionFacts = _parseNutritionFacts(json['nutritionFacts']),
      novaScore = _parseNovaScore(json['novaScore']),
      greenScore = _parseGreenScore(json['greenScore']),
      ingredients = json['ingredients'] != null
          ? List<String>.from(json['ingredients'])
          : null,
      ingredientsWithAllergens = json['ingredientsWithAllergens'],
      traces = json['traces'] != null
          ? List<String>.from(json['traces'])
          : null,
      allergens = json['allergens'] != null
          ? List<String>.from(json['allergens'])
          : null,
      additives = json['additives'] != null
          ? Map<String, String>.from(json['additives'])
          : null,
      nutrientLevels = null,
      ingredientsFromPalmOil = json['ingredientsFromPalmOil'],
      containsPalmOil = ProductAnalysis.fromString(json['containsPalmOil']),
      isVegan = ProductAnalysis.fromString(json['isVegan']),
      isVegetarian = ProductAnalysis.fromString(json['isVegetarian']);

  static ProductNutriScore? _parseNutriScore(String? score) {
    switch (score) {
      case 'A':
        return ProductNutriScore.A;
      case 'B':
        return ProductNutriScore.B;
      case 'C':
        return ProductNutriScore.C;
      case 'D':
        return ProductNutriScore.D;
      case 'E':
        return ProductNutriScore.E;
      default:
        return ProductNutriScore.unknown;
    }
  }

  static ProductNovaScore? _parseNovaScore(String? score) {
    switch (score) {
      case 'group1':
        return ProductNovaScore.group1;
      case 'group2':
        return ProductNovaScore.group2;
      case 'group3':
        return ProductNovaScore.group3;
      case 'group4':
        return ProductNovaScore.group4;
      default:
        return ProductNovaScore.unknown;
    }
  }

  static ProductGreenScore? _parseGreenScore(String? score) {
    switch (score) {
      case 'A':
        return ProductGreenScore.A;
      case 'APlus':
        return ProductGreenScore.APlus;
      case 'B':
        return ProductGreenScore.B;
      case 'C':
        return ProductGreenScore.C;
      case 'D':
        return ProductGreenScore.D;
      case 'E':
        return ProductGreenScore.E;
      case 'F':
        return ProductGreenScore.F;
      default:
        return ProductGreenScore.unknown;
    }
  }

  static ProductNutriScoreLevels? _parseNutriScoreLevels(dynamic json) {
    if (json == null || json is! Map) return null;
    final map = Map<String, dynamic>.from(json);

    ProductNutriScoreLevel? parseLevel(dynamic value) {
      if (value == null || value is! Map) return null;
      final m = Map<String, dynamic>.from(value);

      return ProductNutriScoreLevel(
        points: (m['points'] as num?)?.toDouble() ?? 0,
        maxPoints: (m['maxPoints'] as num?)?.toDouble() ?? 0,
        unit: m['unit']?.toString() ?? '',
        value: (m['value'] as num?)?.toDouble() ?? 0,
        type: m['type'] == 'positive'
            ? ProductNutriScoreLevelType.positive
            : m['type'] == 'negative'
            ? ProductNutriScoreLevelType.negative
            : ProductNutriScoreLevelType.unknown,
      );
    }

    return ProductNutriScoreLevels(
      energy: parseLevel(map['energy']),
      fiber: parseLevel(map['fiber']),
      fruitsVegetablesLegumes: parseLevel(map['fruitsVegetablesLegumes']),
      proteins: parseLevel(map['proteins']),
      salt: parseLevel(map['salt']),
      saturatedFat: parseLevel(map['saturatedFat']),
      sugars: parseLevel(map['sugars']),
    );
  }

  static NutritionFacts? _parseNutritionFacts(dynamic json) {
    if (json == null || json is! Map) {
      return null;
    }

    final data = Map<String, dynamic>.from(json);

    Nutriment? parseNutriment(dynamic value) {
      if (value == null || value is! Map) {
        return null;
      }

      final m = Map<String, dynamic>.from(value);

      return Nutriment(
        unit: m['unit']?.toString() ?? '',
        perServing: m['perServing'],
        per100g: m['per100g'],
      );
    }

    return NutritionFacts(
      servingSize: data['servingSize']?.toString() ?? '',
      calories: parseNutriment(data['calories']),
      fat: parseNutriment(data['fat']),
      saturatedFat: parseNutriment(data['saturatedFat']),
      carbohydrate: parseNutriment(data['carbohydrate']),
      sugar: parseNutriment(data['sugar']),
      fiber: parseNutriment(data['fiber']),
      proteins: parseNutriment(data['proteins']),
      sodium: parseNutriment(data['sodium']),
      salt: parseNutriment(data['salt']),
      energy: parseNutriment(data['energy']),
    );
  }
}

class NutritionFacts {
  final String servingSize;
  final Nutriment? calories;
  final Nutriment? fat;
  final Nutriment? saturatedFat;
  final Nutriment? carbohydrate;
  final Nutriment? sugar;
  final Nutriment? fiber;
  final Nutriment? proteins;
  final Nutriment? sodium;
  final Nutriment? salt;
  final Nutriment? energy;

  NutritionFacts({
    required this.servingSize,
    this.calories,
    this.fat,
    this.saturatedFat,
    this.carbohydrate,
    this.sugar,
    this.fiber,
    this.proteins,
    this.sodium,
    this.salt,
    this.energy,
  });
}

class Nutriment {
  final String unit;
  final dynamic perServing;
  final dynamic per100g;

  Nutriment({required this.unit, this.perServing, this.per100g});
}

class NutrientLevels {
  final String? salt;
  final String? saturatedFat;
  final String? sugars;
  final String? fat;

  NutrientLevels({this.salt, this.saturatedFat, this.sugars, this.fat});
}

class ProductNutriScoreLevels {
  final ProductNutriScoreLevel? energy;
  final ProductNutriScoreLevel? fiber;
  final ProductNutriScoreLevel? fruitsVegetablesLegumes;
  final ProductNutriScoreLevel? proteins;
  final ProductNutriScoreLevel? salt;
  final ProductNutriScoreLevel? saturatedFat;
  final ProductNutriScoreLevel? sugars;

  ProductNutriScoreLevels({
    required this.energy,
    required this.fiber,
    required this.fruitsVegetablesLegumes,
    required this.proteins,
    required this.salt,
    required this.saturatedFat,
    required this.sugars,
  });
}

class ProductNutriScoreLevel {
  final double points;
  final double maxPoints;
  final String unit;
  final double value;
  final ProductNutriScoreLevelType type;

  ProductNutriScoreLevel({
    required this.points,
    required this.maxPoints,
    required this.unit,
    required this.value,
    required this.type,
  });
}

enum ProductNutriScoreLevelType { positive, negative, unknown }

enum ProductNutriScore { A, B, C, D, E, unknown }

enum ProductNovaScore { group1, group2, group3, group4, unknown }

enum ProductGreenScore { A, APlus, B, C, D, E, F, unknown }

enum ProductAnalysis {
  yes,
  no,
  maybe;

  static ProductAnalysis fromString(String? analysis) {
    return switch (analysis) {
      'yes' => ProductAnalysis.yes,
      'no' => ProductAnalysis.no,
      'maybe' => ProductAnalysis.maybe,
      _ => ProductAnalysis.maybe,
    };
  }
}

Product generateProduct() => Product(
  barcode: '1234567890',
  name: 'Nutella',
  altName: 'Product Alt Name',
  picture:
      'https://images.openfoodfacts.org/images/products/301/762/042/5035/front_fr.533.400.jpg',
  quantity: '200g',
  brands: ['Ferrero', 'Ferrero'],
  manufacturingCountries: ['France', 'Italie'],
  nutriScore: ProductNutriScore.E,
  novaScore: ProductNovaScore.group4,
  greenScore: ProductGreenScore.D,
  ingredients: [
    'Sucre',
    'sirop de glucose',
    '_lait_ écrémé',
    'crème légère (_lait_)',
    'eau',
    'beurre de cacao',
    'matière grasse de noix de coco',
    '_lait_ écrémé concentré sucré',
    'pâte de cacao',
    'farine de _blé_',
    'matière grasse de palme',
    '_lait_ écrémé en poudre',
    '_lactose_',
    'matière grasse du _lait_',
    'huile de palmiste',
    'petit-_lait_ en poudre',
    'cacao maigre',
    'beurre (_lait_)',
    'émulsifiants (lécithine de _soja_, E471, tristéarate de sorbitane)',
    '_lait_ entier en poudre',
    'stabilisants (E407, E410, E412)',
    'arômes naturels (_lait_)',
    'sel',
    'colorant naturel (caramel ordinaire)',
    'cacao en poudre',
    'poudre à lever (E503)',
    'extrait naturel de vanille',
  ],
  ingredientsWithAllergens:
      'Sucre, sirop de glucose, <span class=\"allergen\">lait</span> écrémé, crème légère (<span class=\"allergen\">lait</span>), eau, beurre de cacao, matière grasse de noix de coco, <span class=\"allergen\">lait</span> écrémé concentré sucré, pâte de cacao, farine de <span class=\"allergen\">blé</span>, matière grasse de palme, <span class=\"allergen\">lait</span> écrémé en poudre, <span class=\"allergen\">lactose</span>, matière grasse du <span class=\"allergen\">lait</span>, huile de palmiste, petit-<span class=\"allergen\">lait</span> en poudre, cacao maigre, <span class=\"allergen\">beurre</span> (<span class=\"allergen\">lait</span>), émulsifiants (lécithine de <span class=\"allergen\">soja</span>, E471, tristéarate de sorbitane), <span class=\"allergen\">lait</span> entier en poudre, stabilisants (E407, E410, E412), arômes naturels (<span class=\"allergen\">lait</span>), sel, colorant naturel (caramel ordinaire), cacao en poudre, poudre à lever (E503), extrait naturel de vanille. (Peut contenir<span class=\"allergen\">: cacahuète</span>, <span class=\"allergen\">noisette</span>, <span class=\"allergen\">amande</span>).',
  traces: ['cacahuète', 'noisette', 'amande'],
  allergens: ['lait', 'soja', 'beurre'],
  additives: {'e322i': 'Description', 'e471': 'Description'},
  nutriScoreLevels: ProductNutriScoreLevels(
    energy: ProductNutriScoreLevel(
      points: 3,
      maxPoints: 10,
      unit: 'kJ',
      value: 1180,
      type: ProductNutriScoreLevelType.negative,
    ),
    saturatedFat: ProductNutriScoreLevel(
      points: 9,
      maxPoints: 10,
      unit: 'g',
      value: 9.05,
      type: ProductNutriScoreLevelType.negative,
    ),
    sugars: ProductNutriScoreLevel(
      points: 7,
      maxPoints: 15,
      unit: 'g',
      value: 25.5,
      type: ProductNutriScoreLevelType.negative,
    ),
    proteins: ProductNutriScoreLevel(
      points: 1,
      maxPoints: 7,
      unit: 'g',
      value: 3.5,
      type: ProductNutriScoreLevelType.positive,
    ),
    fiber: ProductNutriScoreLevel(
      points: 0,
      maxPoints: 5,
      unit: 'g',
      value: 0,
      type: ProductNutriScoreLevelType.unknown,
    ),
    salt: ProductNutriScoreLevel(
      points: 1,
      maxPoints: 20,
      unit: 'g',
      value: 0,
      type: ProductNutriScoreLevelType.positive,
    ),
    fruitsVegetablesLegumes: ProductNutriScoreLevel(
      points: 0,
      maxPoints: 5,
      unit: '%',
      value: 0,
      type: ProductNutriScoreLevelType.positive,
    ),
  ),
  nutrientLevels: NutrientLevels(
    salt: 'Low',
    saturatedFat: 'Low',
    sugars: 'Low',
    fat: 'Low',
  ),
  nutritionFacts: NutritionFacts(
    servingSize: '100g',
    calories: Nutriment(unit: 'kcal', perServing: 100, per100g: 100),
    fat: Nutriment(unit: 'g', perServing: 10, per100g: 10),
    saturatedFat: Nutriment(unit: 'g', perServing: 5, per100g: 5),
    carbohydrate: Nutriment(unit: 'g', perServing: 20, per100g: 20),
    sugar: Nutriment(unit: 'g', perServing: 10, per100g: 10),
    fiber: Nutriment(unit: 'g', perServing: 5, per100g: 5),
    proteins: Nutriment(unit: 'g', perServing: 10, per100g: 10),
    sodium: Nutriment(unit: 'mg', perServing: 100, per100g: 100),
    salt: Nutriment(unit: 'g', perServing: 0.1, per100g: 0.1),
  ),
);
