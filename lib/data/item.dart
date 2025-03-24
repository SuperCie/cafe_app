import 'package:intl/intl.dart';

class Item {
  final String id;
  final String name;
  final String imagePath;
  final double price;
  final String description;
  final categoryItem category;
  List<addonItem> availableAddon;

  Item({
    required dynamic id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.availableAddon,
  }) : id = id.toString();

  //formated price
  String get formattedPrice {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(price);
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'].toString(),
      name: map['name'],
      description: map['description'],
      price: map['price'],
      category: categoryItem.values[map['category']],
      imagePath: map['imagePath'],
      availableAddon:
          (map['availableAddon'] as List)
              .map((addon) => addonItem.fromMap(addon))
              .toList(),
    );
  }
}

enum categoryItem { all, coffee, signature, noncoffee }

class addonItem {
  int id;
  String name;
  double price;
  Addoncategory category;

  addonItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  String get formatedAddon {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(price);
  }

  factory addonItem.fromMap(Map<String, dynamic> map) {
    return addonItem(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      category: Addoncategory.values[map['category']],
    );
  }
}

enum Addoncategory { Milk, Special }
