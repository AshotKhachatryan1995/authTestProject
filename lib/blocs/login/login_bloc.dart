import 'package:auth_test_project/blocs/login/login_event.dart';
import 'package:auth_test_project/blocs/login/login_state.dart';
import 'package:auth_test_project/extensions/string_extension.dart';
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
    emit(LoadingState());
    final box = await Hive.openBox<User>('users_db');

    final login = event.controllers.loginController.text;
    final password = event.controllers.passwordController.text;
    final users = box.values.where((user) => user.login == login).toList();

    if (users.isEmpty) {
      emit(UserSignInInvalidState());
      return;
    }

    final user = users.first;

    if (user.password == password.generateMd5()) {
      await _sharedPrefs.setString('userId', user.id);

      emit(UserSignInSuccessfullyState());
      return;
    }

    emit(UserSignInInvalidState());
  }
}
