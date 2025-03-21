import 'package:coffee_app/autentication/loginscreen.dart';
import 'package:coffee_app/autentication/registscreen.dart';
import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/data/paymethprovider.dart';
import 'package:coffee_app/data/storeprovider.dart';
import 'package:coffee_app/models/theme/themerepo.dart';
import 'package:coffee_app/screens/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Themerepo()),
        ChangeNotifierProvider(create: (context) => Menuitem()),
        ChangeNotifierProvider(create: (context) => Storeprovider()),
        ChangeNotifierProvider(create: (context) => Paymethprovider()),
      ],
      child: CoffeeApp(),
    ),
  );
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginscreen(),
      theme: Provider.of<Themerepo>(context).themeData,
    );
  }
}
