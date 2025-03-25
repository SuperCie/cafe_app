import 'package:coffee_app/data/store.dart';
import 'package:flutter/material.dart';

class Storeprovider extends ChangeNotifier {
  Store? _selectedStore;

  Store? get selectedStore => _selectedStore;

  String get storeInitials {
    if (_selectedStore == null || _selectedStore!.name.isEmpty) {
      return 'Default';
    }
    // untuk inisial store
    List<String> words = _selectedStore!.name.split('');
    String initials = '';
    for (int i = 0; i < words.length && initials.length < 3; i++) {
      if (words[i].isNotEmpty) {
        initials += words[i][0].toUpperCase();
      }
    }
    return initials;
  }

  void setStore(Store store) {
    _selectedStore = store;
    notifyListeners();
  }

  void clearStore() {
    _selectedStore = null;
    notifyListeners();
  }
}
