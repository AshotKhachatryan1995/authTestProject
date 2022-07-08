import 'package:auth_test_project/blocs/registration/registration_bloc.dart';
import 'package:auth_test_project/blocs/registration/registration_event.dart';
import 'package:auth_test_project/blocs/registration/registration_state.dart';
import 'package:auth_test_project/controllers/registration_controllers.dart';
import 'package:auth_test_project/shared/centered_button_widget.dart';
import 'package:auth_test_project/shared/loading_widget.dart';
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
  void dispose() {
    _controllers.dispose();
    _registrationBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
        create: (context) => _registrationBloc,
        child: BlocConsumer<RegistrationBloc, RegistrationState>(
            listener: _listener,
            builder: (context, state) => LoadingWidget(
                isLoading: state is LoadingState,
                child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Scaffold(
                        backgroundColor: Colors.white,
                        body: SafeArea(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                            ])))))));
  }

  Widget _renderSignUpButton() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      final isActive = (state is ButtonState) ? state.isActive : false;

      return CenteredButtonWidget(
        title: 'Sign Up',
        isActive: isActive,
        onPressed: () => _onSignUp(isActive),
      );
    });
  }
}

extension _RegistrationScreenStateAddition on _RegistrationScreenState {
  void _onChanged(String val) => _registrationBloc
      .add(TextFieldValueChangedEvent(controllers: _controllers));

  void _onSignUp(bool isActive) {
    if (!isActive) {
      return;
    }

    _registrationBloc.add(CreateUserEvent(controllers: _controllers));
  }

  void _listener(context, state) {
    if (state is UserCreatedSuccessfullyState) {
      Navigator.pushNamed(context, '/home');
    }

    if (state is UserAlreadyExists) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const AlertDialog(
              title: Text('This username already exists',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.red))));
    }
  }
}
