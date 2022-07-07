import 'package:auth_test_project/blocs/authentication/authentication_bloc.dart';
import 'package:auth_test_project/blocs/sign_up/registration_bloc.dart';
import 'package:auth_test_project/blocs/sign_up/registration_event.dart';
import 'package:auth_test_project/blocs/sign_up/registration_state.dart';
import 'package:auth_test_project/controllers/registration_controllers.dart';
import 'package:auth_test_project/shared/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final RegistrationBloc _registrationBloc;
  final RegistrationControllers _controllers = RegistrationControllers();

  @override
  void initState() {
    super.initState();
    _registrationBloc = RegistrationBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
        create: (context) => _registrationBloc,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Column(children: [
                    TextFieldWidget(
                        controller: _controllers.nameController,
                        hintText: 'enter your name',
                        onChanged: _onChanged),
                    TextFieldWidget(
                        controller: _controllers.loginController,
                        hintText: 'enter login',
                        onChanged: _onChanged),
                    TextFieldWidget(
                        controller: _controllers.passwordController,
                        hintText: 'enter password',
                        obscureText: true,
                        onChanged: _onChanged)
                  ]),
                  _renderSignUpButton()
                ]))));
  }

  Widget _renderSignUpButton() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      final isActive = (state is ButtonState) ? state.isActive : false;

      return TextButton(
          onPressed: () => _onSignUp(isActive),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: color(isActive),
                  borderRadius: BorderRadius.circular(10)),
              child: Text('Sign up',
                  style: TextStyle(fontSize: 20, color: color(!isActive)))));
    });
  }
}

extension _RegistrationScreenStateAddition on _RegistrationScreenState {
  Color color(bool isActive) => isActive ? Colors.black : Colors.white;

  void _onChanged(String val) => _registrationBloc
      .add(TextFieldValueChangedEvent(controllers: _controllers));

  void _onSignUp(bool isActive) {
    if (!isActive) {
      return;
    }

    _registrationBloc.add(CreateNewUserEvent(controllers: _controllers));
  }
}
