import 'package:coffee_app/data/store.dart';
import 'package:flutter/material.dart';

class Storeprovider extends ChangeNotifier {
  Store? _selectedStore;

  Store? get selectedStore => _selectedStore;
}
