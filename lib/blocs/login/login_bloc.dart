import 'package:auth_test_project/blocs/login/login_event.dart';
import 'package:auth_test_project/blocs/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState()) {
    on<TextFieldValueChangedEvent>(_onTextFieldValueChangedEvent);
    on<UserSignInEvent>(_onUserSignInEvent);
  }

  Future<void> _onTextFieldValueChangedEvent(
      TextFieldValueChangedEvent event, Emitter<LoginState> emit) async {
    final controllers = event.controllers;

    final isValid = controllers.areNotEmpty;

    emit(ButtonState(isActive: isValid));
  }

  Future<void> _onUserSignInEvent(
      UserSignInEvent event, Emitter<LoginState> emit) async {
    // TODO check user exists in db
  }
}
