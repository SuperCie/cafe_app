import 'package:coffee_app/data/item.dart';
import 'package:intl/intl.dart';

class Cart {
  Item item;
  int quantity;
  List<addonItem> selectedAddon;

  Cart({required this.item, this.quantity = 1, required this.selectedAddon});

  double get subTotalProduct {
    return item.price * quantity;
  }

  double get totalPrice {
    double addonsPrice = selectedAddon.fold(
      0,
      (sum, addon) => sum + addon.price,
    );
    return (item.price + addonsPrice) * quantity;
  }

  String get formattedPrice {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(totalPrice);
  }

  // Convert Cart to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'item': {
        'id': item.id.toString(),
        'name': item.name,
        'description': item.description,
        'price': item.price,
        'imagePath': item.imagePath,
        'category': item.category.toString(),
      },
      'quantity': quantity,
      'selectedAddon':
          selectedAddon
              .map(
                (addon) => {
                  'id': addon.id,
                  'name': addon.name,
                  'price': addon.price,
                  'category': addon.category.toString(),
                },
              )
              .toList(),
    };
  }

  // Create Cart from Firestore Map
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      item: Item(
        id: map['item']['id'],
        name: map['item']['name'],
        description: map['item']['description'],
        price: map['item']['price'],
        imagePath: map['item']['imagePath'],
        category: categoryItem.values.firstWhere(
          (e) => e.toString() == map['item']['category'],
        ),
        availableAddon: [], // Addons are not needed here
      ),
      quantity: map['quantity'],
      selectedAddon:
          (map['selectedAddon'] as List<dynamic>).map((addon) {
            return addonItem(
              id: addon['id'],
              name: addon['name'],
              price: addon['price'],
              category: Addoncategory.values.firstWhere(
                (e) => e.toString() == addon['category'],
              ),
            );
          }).toList(),
    );
  }
}
