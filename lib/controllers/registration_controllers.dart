import 'package:flutter/material.dart';

class RegistrationControllers {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool get areNotEmpty =>
      loginController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      nameController.text.isNotEmpty;

  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
