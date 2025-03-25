import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/autentication/helper/displayerror.dart';
import 'package:coffee_app/data/cart.dart';
import 'package:coffee_app/data/item.dart';
import 'package:coffee_app/data/paymethprovider.dart';
import 'package:coffee_app/data/paymeths.dart';
import 'package:coffee_app/data/store.dart';
import 'package:coffee_app/data/storeprovider.dart';
import 'package:coffee_app/screens/thankscreen.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Menuitem extends ChangeNotifier {
  final FirebaseFirestore _itemdb = FirebaseFirestore.instance;
  final List<Item> _items = [
    // Kategori Coffee
    Item(
      id: 001,
      name: 'Kopi Gula Merah',
      description: 'Kopi dengan rasa manis dan sedikit asam dari gula merah.',
      price: 23000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/gulamerah.jpeg',
      availableAddon: [
        addonItem(
          id: 01,
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 02,
          name: 'Soya Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 03,
          name: 'Oat Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 04,
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 05,
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 06,
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 07,
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 08,
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      id: 002,
      name: 'Kopi Rum',
      description: 'Kopi dengan tambahan rum yang memberi aroma khas.',
      price: 21000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/kopirum.jpeg',
      availableAddon: [
        addonItem(
          id: 01,
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 02,
          name: 'Soya Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 03,
          name: 'Oat Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 04,
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 05,
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 06,
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 07,
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 08,
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      id: 003,
      name: 'Kopi Hitam',
      description: 'Kopi hitam pekat tanpa tambahan apapun.',
      price: 18000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/kopihitam.jpeg',
      availableAddon: [
        addonItem(
          id: 01,
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 02,
          name: 'Soya Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 03,
          name: 'Oat Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 04,
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 05,
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 06,
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 07,
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 08,
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      id: 004,
      name: 'Cappucino',
      description: 'Kopi dengan susu berbusa dan sedikit rasa pahit.',
      price: 20000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/cappucino.jpeg',
      availableAddon: [
        addonItem(
          id: 01,
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 02,
          name: 'Soya Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 03,
          name: 'Oat Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 04,
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 05,
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 06,
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 07,
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 08,
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      id: 005,
      name: 'Kopi Soe Lowfat',
      description: 'Kopi rendah lemak dengan rasa ringan.',
      price: 20000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/lowfatkopi.jpeg',
      availableAddon: [
        addonItem(
          id: 01,
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 02,
          name: 'Soya Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 03,
          name: 'Oat Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 04,
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 05,
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 06,
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 07,
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 08,
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      id: 006,
      name: 'Kopi Caramel',
      description: 'Kopi dengan tambahan rasa caramel manis.',
      price: 25000,
      category: categoryItem.coffee,
      imagePath: 'assets/images/caramel.jpeg',
      availableAddon: [
        addonItem(
          id: 01,
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 02,
          name: 'Soya Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 03,
          name: 'Oat Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 04,
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 05,
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 06,
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 07,
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 08,
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    // Kategori Signature
    Item(
      id: 007,
      name: 'Kopi Soya',
      description: 'Kopi dengan susu kedelai yang lembut.',
      price: 23000,
      category: categoryItem.signature,
      imagePath: 'assets/images/kopisoya.jpeg',
      availableAddon: [
        addonItem(
          id: 01,
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 02,
          name: 'Soya Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 03,
          name: 'Oat Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 04,
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 05,
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 06,
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 07,
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 08,
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      id: 008,
      name: 'Cokelat Soya',
      description: 'Cokelat dengan susu kedelai yang creamy.',
      price: 23000,
      category: categoryItem.signature,
      imagePath: 'assets/images/coklatsoya.jpeg',
      availableAddon: [
        addonItem(
          id: 01,
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 02,
          name: 'Soya Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 03,
          name: 'Oat Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 04,
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 05,
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 06,
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 07,
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 08,
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    // Kategori Non-Coffee
    Item(
      id: 009,
      name: 'Matcha Latte',
      description: 'Minuman dengan rasa matcha yang lembut dan creamy.',
      price: 23000,
      category: categoryItem.noncoffee,
      imagePath: 'assets/images/matcha.jpeg',
      availableAddon: [
        addonItem(
          id: 01,
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 02,
          name: 'Soya Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 03,
          name: 'Oat Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 04,
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 05,
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 06,
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 07,
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 08,
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
    Item(
      id: 010,
      name: 'Cokelat Rum',
      description:
          'Cokelat yang dipadukan dengan rum untuk rasa yang lebih kaya.',
      price: 26000,
      category: categoryItem.noncoffee,
      imagePath: 'assets/images/coklatrum.jpeg',
      availableAddon: [
        addonItem(
          id: 01,
          name: 'Low Fat Milk',
          price: 5000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 02,
          name: 'Soya Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 03,
          name: 'Oat Milk',
          price: 8000,
          category: Addoncategory.Milk,
        ),
        addonItem(
          id: 04,
          name: 'Extra Rum',
          price: 6000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 05,
          name: 'Extra Es Krim',
          price: 7000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 06,
          name: 'Extra Espresso',
          price: 5000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 07,
          name: 'Extra Regal',
          price: 4000,
          category: Addoncategory.Special,
        ),
        addonItem(
          id: 08,
          name: 'Extra Saus Caramel',
          price: 8000,
          category: Addoncategory.Special,
        ),
      ],
    ),
  ];

  List<Item> get item => _items;

  void uploadMenuToFirestore() async {
    final CollectionReference menuCollection = _itemdb.collection('menu');

    for (var item in _items) {
      await menuCollection.doc(item.id.toString()).set({
        'name': item.name,
        'description': item.description,
        'price': item.price,
        'category': item.category.toString(),
        'imagePath': item.imagePath,
        'availableAddon':
            item.availableAddon
                .map(
                  (addon) => {
                    'id': addon.id,
                    'name': addon.name,
                    'price': addon.price,
                    'category': addon.category.toString(),
                  },
                )
                .toList(),
      });
    }
    print('Data berhasil diunggah ke Firestore!');
  }

  Stream<List<Item>> fetchMenuFromFirestore() {
    return _itemdb.collection('menu').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        return Item(
          id: int.parse(doc.id),
          name: data['name'],
          description: data['description'],
          price: data['price'],
          category: categoryItem.coffee, // Ubah sesuai kategori
          imagePath: data['imagePath'],
          availableAddon:
              (data['availableAddon'] as List<dynamic>).map((addon) {
                return addonItem(
                  id: addon['id'],
                  name: addon['name'],
                  price: addon['price'],
                  category: Addoncategory.Special, // Ubah sesuai kategori
                );
              }).toList(),
        );
      }).toList();
    });
  }

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
  bool isloading = true;

  // function
  // Save cart to Firestore
  Future<void> _saveCartToFirestore(String? uid) async {
    if (uid == null) return;

    final CollectionReference cartCollection = _itemdb
        .collection('users')
        .doc(uid)
        .collection('cart');

    for (var cartItem in _cart) {
      await cartCollection
          .doc(cartItem.item.id.toString())
          .set(cartItem.toMap());
    }
  }

  Future<void> fetchCartFromFirestore(String? uid, BuildContext context) async {
    if (uid == null) {
      _cart = [];
      isloading = false;
      notifyListeners();
      return;
    }
    try {
      final QuerySnapshot cartSnapshot =
          await _itemdb.collection('users').doc(uid).collection('cart').get();
      _cart =
          cartSnapshot.docs.map((doc) {
            return Cart.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

      isloading = false;
      notifyListeners();
      _checkCartEmpty(context);
    } catch (e) {
      _cart = [];
      isloading = false;
      notifyListeners();
    }
  }

  // method untuk memeriksa cart secara realtime
  Stream<List<Cart>> getCartStream(String? uid) {
    if (uid == null) return Stream.value([]);

    return _itemdb
        .collection('users')
        .doc(uid)
        .collection('cart')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => Cart.fromMap(doc.data() as Map<String, dynamic>),
                  )
                  .toList(),
        );
  }

  // add to cart

  void addCartItem(
    Item item,
    List<addonItem> selectedAddons,
    String? uid,
  ) async {
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

    await _saveCartToFirestore(uid);
    notifyListeners();
  }

  // delete cart item
  Future<void> deleteCart(
    Cart cartItem,
    BuildContext context,
    String? uid,
  ) async {
    try {
      final cartRef = _itemdb.collection('users').doc(uid).collection('cart');
      final itemDoc = cartRef.doc(cartItem.item.id.toString());

      int cartIndex = _cart.indexOf(cartItem);
      if (cartIndex != -1) {
        if (_cart[cartIndex].quantity > 1) {
          _cart[cartIndex].quantity--;
          await _saveCartToFirestore(uid);
        } else {
          _cart.removeAt(cartIndex);
          await itemDoc.delete();
        }
      }
      _checkCartEmpty(context);
      notifyListeners();
    } catch (e) {
      displayError(context, e.toString());
    }
  }

  // clear all item in cart
  Future<void> deleteAllCart(BuildContext context, String? uid) async {
    try {
      final cartRef = _itemdb.collection('users').doc(uid).collection('cart');
      final snapshot = await cartRef.get();

      if (snapshot.docs.isNotEmpty) {
        WriteBatch batch = _itemdb.batch();
        for (var doc in snapshot.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
      }

      // Kosongkan cart lokal
      _cart.clear();
      if (context.mounted) {
        Provider.of<Storeprovider>(context, listen: false).clearStore();
        Provider.of<Paymethprovider>(context, listen: false).clearMethod();
        notifyListeners();
      }
    } catch (e) {
      displayError(context, e.toString());
    }
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

  // ordered
  Future<void> checkOutOrder({
    required String uid,
    required String userName,
    required String storeName,
    required String paymentMethod,
    context,
  }) async {
    if (_cart.isEmpty) return;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      final CollectionReference orderCollection = _itemdb
          .collection('users')
          .doc(uid)
          .collection('transaction');

      //generate transaction id
      final QuerySnapshot ordersnapshot = await orderCollection.get();
      final int orderNumber = ordersnapshot.docs.length + 1;
      final String transactionId =
          "#KS-${orderNumber.toString().padLeft(5, '0')}";

      // convert
      final List<Map<String, dynamic>> items =
          _cart
              .map(
                (cartItems) => {
                  'name': cartItems.item.name,
                  'price': cartItems.item.price,
                  'qty': cartItems.quantity,
                  'addons': cartItems.selectedAddon.map((addon) => addon.name),
                  'total': totalAllCart,
                },
              )
              .toList();

      //simpan order ke database
      await orderCollection.doc(transactionId).set({
        'transactionId': transactionId,
        'userId': uid,
        'userName': userName,
        'storeName': storeName,
        'items': items,
        'payment': paymentMethod,
        'note': restaurantNote,
        'timestamp': FieldValue.serverTimestamp(),
      });
      await deleteAllCart(context, uid);

      if (context.mounted) {
        Navigator.pop(context);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) => Thankscreen(),
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        displayError(context, e.toString());
      }
    }
  }
}
