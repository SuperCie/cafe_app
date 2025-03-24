import 'package:coffee_app/autentication/authgate.dart';
import 'package:coffee_app/data/database/userprovider.dart';
import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/data/paymethprovider.dart';
import 'package:coffee_app/data/storeprovider.dart';
import 'package:coffee_app/models/theme/themerepo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Menuitem().uploadMenuToFirestore();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Themerepo()),
        ChangeNotifierProvider(create: (context) => Menuitem()),
        ChangeNotifierProvider(create: (context) => Storeprovider()),
        ChangeNotifierProvider(create: (context) => Paymethprovider()),
        ChangeNotifierProvider(create: (context) => Userprovider()),
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
      home: Authgate(),
      theme: Provider.of<Themerepo>(context).themeData,
    );
  }
}
