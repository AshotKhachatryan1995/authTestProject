import 'package:auth_test_project/blocs/login/login_bloc.dart';
import 'package:auth_test_project/blocs/login/login_event.dart';
import 'package:auth_test_project/blocs/login/login_state.dart';
import 'package:auth_test_project/controllers/login_controllers.dart';
import 'package:auth_test_project/shared/centered_button_widget.dart';
import 'package:auth_test_project/shared/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginBloc _loginBloc;
  final LoginControllers _controllers = LoginControllers();

  @override
  void initState() {
    super.initState();

    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    _controllers.dispose();
    _loginBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => _loginBloc,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                      Column(children: [
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
                      _renderSignInButton()
                    ])))));
  }

  Widget _renderSignInButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      final isActive = (state is ButtonState) ? state.isActive : false;

      return CenteredButtonWidget(
        isActive: isActive,
        onPressed: () => _onSignIn(isActive),
      );
    });
  }
}

extension _LoginScreenStateAddition on _LoginScreenState {
  void _onChanged(String val) =>
      _loginBloc.add(TextFieldValueChangedEvent(controllers: _controllers));

  void _onSignIn(bool isActive) {
    if (!isActive) {
      return;
    }

    _loginBloc.add(UserSignInEvent(controllers: _controllers));
  }
}
