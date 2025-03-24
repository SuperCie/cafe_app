import 'package:coffee_app/data/cart.dart';
import 'package:coffee_app/data/item.dart';
import 'package:coffee_app/data/paymethprovider.dart';
import 'package:coffee_app/data/paymeths.dart';
import 'package:coffee_app/data/store.dart';
import 'package:coffee_app/data/storeprovider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Menuitem extends ChangeNotifier {
  final List<Item> _items = [
    // Kategori Coffee
    Item(
      name: 'Kopi Gula Merah',
      description: 'Kopi dengan rasa manis dan sedikit asam dari gula merah.',
      price: 23000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/gulamerah.jpeg',
      availableAddon: [
        addonItem(
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(name: 'Soya Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(name: 'Oat Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      name: 'Kopi Rum',
      description: 'Kopi dengan tambahan rum yang memberi aroma khas.',
      price: 21000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/kopirum.jpeg',
      availableAddon: [
        addonItem(
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(name: 'Soya Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(name: 'Oat Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      name: 'Kopi Hitam',
      description: 'Kopi hitam pekat tanpa tambahan apapun.',
      price: 18000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/kopihitam.jpeg',
      availableAddon: [
        addonItem(
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(name: 'Soya Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(name: 'Oat Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      name: 'Cappucino',
      description: 'Kopi dengan susu berbusa dan sedikit rasa pahit.',
      price: 20000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/cappucino.jpeg',
      availableAddon: [
        addonItem(
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(name: 'Soya Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(name: 'Oat Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      name: 'Kopi Soe Lowfat',
      description: 'Kopi rendah lemak dengan rasa ringan.',
      price: 20000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/lowfatkopi.jpeg',
      availableAddon: [
        addonItem(
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(name: 'Soya Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(name: 'Oat Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      name: 'Kopi Caramel',
      description: 'Kopi dengan tambahan rasa caramel manis.',
      price: 25000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/caramel.jpeg',
      availableAddon: [
        addonItem(
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(name: 'Soya Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(name: 'Oat Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),

    // Kategori Signature
    Item(
      name: 'Kopi Soya',
      description: 'Kopi dengan susu kedelai yang lembut.',
      price: 23000,
      category: categoryItem.signature,
      imagePath: 'assets/images/kopisoya.jpeg',
      availableAddon: [
        addonItem(
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(name: 'Soya Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(name: 'Oat Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      name: 'Cokelat Soya',
      description: 'Cokelat dengan susu kedelai yang creamy.',
      price: 23000,
      category: categoryItem.signature,
      imagePath: 'assets/images/coklatsoya.jpeg',
      availableAddon: [
        addonItem(
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(name: 'Soya Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(name: 'Oat Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),

    // Kategori Non-Coffee
    Item(
      name: 'Matcha Latte',
      description: 'Minuman dengan rasa matcha yang lembut dan creamy.',
      price: 23000,
      category: categoryItem.noncoffee,
      imagePath: 'assets/images/matcha.jpeg',
      availableAddon: [
        addonItem(
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(name: 'Soya Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(name: 'Oat Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      name: 'Cokelat Rum',
      description:
          'Cokelat yang dipadukan dengan rum untuk rasa yang lebih kaya.',
      price: 26000,
      category: categoryItem.noncoffee,
      imagePath: 'assets/images/coklatrum.jpeg',
      availableAddon: [
        addonItem(
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(name: 'Soya Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(name: 'Oat Milk', price: 8000, category: Addoncategory.Milk),
        addonItem(
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
  ];

  List<Item> get item => _items;

  // filter item berdasarkan category
  categoryItem _selectedCategory = categoryItem.all;

  List<Item> get selectedItem {
    // Jika kategori yang dipilih adalah all, kembalikan semua item
    if (_selectedCategory == categoryItem.all) {
      return _items;
    }
    // Jika bukan, filter berdasarkan kategori
    return _items.where((item) => item.category == _selectedCategory).toList();
  }

  categoryItem get selectedCategory => _selectedCategory;

  // Fungsi untuk mengubah kategori yang dipilih
  void setCategory(categoryItem category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // CART

  List<Cart> _cart = [];
  List<Cart> get cart => _cart;

  // function

  // add to cart
  void addCartItem(Item item, List<addonItem> selectedAddons) {
    Cart? cartItem = _cart.firstWhereOrNull((beverage) {
      bool isSameProduct = beverage.item == item;
      bool isSameAddons = ListEquality().equals(
        beverage.selectedAddon,
        selectedAddons,
      );
      return isSameProduct && isSameAddons;
    });

    //if item already exists
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(Cart(item: item, selectedAddon: selectedAddons));
    }
    notifyListeners();
  }

  // delete cart item
  void deleteCart(Cart cartItem, BuildContext context) {
    int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    _checkCartEmpty(context);
    notifyListeners();
  }

  // clear all item in cart
  void deleteAllCart(BuildContext context) {
    cart.clear();
    _checkCartEmpty(context);
    notifyListeners();
  }

  // TOTAL PRICE FOR CART ITEM
  double get totalCartPrice {
    return cart.fold(0, (sum, cartItem) => sum + cartItem.totalPrice);
  }

  String get formattedTCP {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(totalCartPrice);
  }

  // ADMIN FEE
  double get adminFee => 1000;
  String get formattedAdmin {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(adminFee);
  }

  // GRANDTOTAL
  double get totalAllCart {
    return totalCartPrice + adminFee;
  }

  String get formattedTTA {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(totalAllCart);
  }

  // user input note data
  String restaurantNote = '';

  //  input driver note
  void userInputRstNote(String restaurantNt) {
    restaurantNote = restaurantNt;
    notifyListeners();
  }

  void _checkCartEmpty(BuildContext context) {
    if (cart.isEmpty) {
      Provider.of<Storeprovider>(context, listen: false).clearStore();
      Provider.of<Paymethprovider>(context, listen: false).clearMethod();
    }
  }

}
