import 'package:auth_test_project/controllers/registration_controllers.dart';
import 'package:uuid/uuid.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.registrTime,
  });

  final String id;
  final String name;
  final String login;
  final String password;
  final DateTime registrTime;

  factory User.fromControllers(RegistrationControllers controllers) => User(
      id: const Uuid().v4(),
      name: controllers.nameController.text,
      login: controllers.loginController.text,
      password: controllers.passwordController.text,
      registrTime: DateTime.now());
}
