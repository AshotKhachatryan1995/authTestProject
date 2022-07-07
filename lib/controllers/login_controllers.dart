import 'package:flutter/material.dart';

class LoginControllers {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get areNotEmpty =>
      loginController.text.isNotEmpty && passwordController.text.isNotEmpty;

  void dispose() {
    loginController.dispose();
    passwordController.dispose();
  }
}
