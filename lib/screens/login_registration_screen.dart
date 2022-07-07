import 'package:flutter/material.dart';

class LoginRegistrationScreen extends StatefulWidget {
  const LoginRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginRegistrationScreenState();
}

class _LoginRegistrationScreenState extends State<LoginRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _renderButton(loginType: LoginType.signUp),
            const SizedBox(height: 20),
            _renderButton(loginType: LoginType.login)
          ],
        ));
  }

  Widget _renderButton({required LoginType loginType}) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, loginType.routeName()),
        child: Align(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  loginType.title(),
                  style: const TextStyle(color: Colors.black),
                ))));
  }
}

enum LoginType { signUp, login }

extension _LoginTypeAddition on LoginType {
  String title() {
    switch (this) {
      case LoginType.signUp:
        return 'Sign Up';
      case LoginType.login:
        return 'Log In';
    }
  }

  String routeName() {
    switch (this) {
      case LoginType.signUp:
        return '/signUp';
      case LoginType.login:
        return '/logIn';
    }
  }
}
