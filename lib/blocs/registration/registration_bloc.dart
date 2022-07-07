import 'package:auth_test_project/blocs/registration/registration_event.dart';
import 'package:auth_test_project/blocs/registration/registration_state.dart';
import 'package:auth_test_project/models/user.dart';
import 'package:auth_test_project/preferance/shared_preferance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(InitialState()) {
    on<TextFieldValueChangedEvent>(_onTextFieldValueChangedEvent);
    on<CreateUserEvent>(_onCreateUserEvent);
  }

  final _sharedPrefs = SharedPrefs();

  Future<void> _onTextFieldValueChangedEvent(
      TextFieldValueChangedEvent event, Emitter<RegistrationState> emit) async {
    final controllers = event.controllers;

    final isValid = controllers.areNotEmpty;

    emit(ButtonState(isActive: isValid));
  }

  Future<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<RegistrationState> emit) async {
    final controllers = event.controllers;

    final user = User(
        id: const Uuid().v4(),
        name: controllers.nameController.text,
        login: controllers.loginController.text,
        password: controllers.passwordController.text,
        registrationDate: DateTime.now());

    try {
      final box = await Hive.openBox<User>('users_db');

      await box.put(user.id, user);
      await _sharedPrefs.setString('userId', user.id);

      await box.close();
    } catch (e) {
      emit(UserCreateInvalidState());
      throw Exception(e.toString());
    }

    emit(UserCreatedSuccessfullyState());
  }
}
