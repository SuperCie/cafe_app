import 'package:coffee_app/data/paymeths.dart';
import 'package:flutter/material.dart';

class Paymethprovider extends ChangeNotifier {
  Paymeths? _selectedMethods;

  Paymeths? get selectedMethods => _selectedMethods;
}
