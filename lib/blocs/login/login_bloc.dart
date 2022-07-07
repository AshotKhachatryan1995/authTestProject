import 'package:auth_test_project/blocs/login/login_event.dart';
import 'package:auth_test_project/blocs/login/login_state.dart';
import 'package:auth_test_project/models/user.dart';
import 'package:auth_test_project/preferance/shared_preferance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState()) {
    on<TextFieldValueChangedEvent>(_onTextFieldValueChangedEvent);
    on<UserSignInEvent>(_onUserSignInEvent);
  }

  final _sharedPrefs = SharedPrefs();

  Future<void> _onTextFieldValueChangedEvent(
      TextFieldValueChangedEvent event, Emitter<LoginState> emit) async {
    final controllers = event.controllers;

    final isValid = controllers.areNotEmpty;

    emit(ButtonState(isActive: isValid));
  }

  Future<void> _onUserSignInEvent(
      UserSignInEvent event, Emitter<LoginState> emit) async {
    final box = await Hive.openBox<User>('users_db');

    final login = event.controllers.loginController.text;
    final password = event.controllers.passwordController.text;
    final user = box.values.where((user) => user.login == login).toList().first;
    await box.close();

    if (user.password == password) {
      await _sharedPrefs.setString('userId', user.id);

      emit(UserSignInSuccessfullyState());
      return;
    }

    emit(UserSignInInvalidState());
  }
}
