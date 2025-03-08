import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/models/theme/themerepo.dart';
import 'package:coffee_app/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Themerepo()),
        ChangeNotifierProvider(create: (context) => Menuitem()),
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
      home: Homescreen(),
      theme: Provider.of<Themerepo>(context).themeData,
    );
  }
}
