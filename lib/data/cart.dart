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
}
