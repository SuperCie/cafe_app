import 'package:coffee_app/autentication/loginscreen.dart';
import 'package:coffee_app/autentication/registscreen.dart';
import 'package:flutter/material.dart';

class Handler extends StatefulWidget {
  const Handler({super.key});

  @override
  State<Handler> createState() => _HandlerState();
}

class _HandlerState extends State<Handler> {
  bool isLoginPage = true;

  void pageHandler() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginPage) {
      return Loginscreen(onpressed: pageHandler,);
    } else {
      return Registscreen(onpressed: pageHandler,);
    }
  }
}
