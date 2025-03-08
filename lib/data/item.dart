import 'package:intl/intl.dart';

class Item {
  final String name;
  final String imagePath;
  final double price;
  final String description;
  final categoryItem category;
  List<addonItem> availableAddon;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.availableAddon,
  });

  //formated price
  String get formattedPrice {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(price);
  }
}

enum categoryItem { all, coffee, signature, noncoffee }

class addonItem {
  String name;
  double price;
  Addoncategory category;

  addonItem({required this.name, required this.price, required this.category});

  String get formatedAddon {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(price);
  }
}

enum Addoncategory { Milk, Special }
