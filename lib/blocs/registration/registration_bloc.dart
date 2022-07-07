import 'package:auth_test_project/blocs/registration/registration_event.dart';
import 'package:auth_test_project/blocs/registration/registration_state.dart';
import 'package:auth_test_project/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(InitialState()) {
    on<TextFieldValueChangedEvent>(_onTextFieldValueChangedEvent);
    on<CreateUserEvent>(_onCreateUserEvent);
  }

  Future<void> _onTextFieldValueChangedEvent(
      TextFieldValueChangedEvent event, Emitter<RegistrationState> emit) async {
    final controllers = event.controllers;

    final isValid = controllers.areNotEmpty;

    emit(ButtonState(isActive: isValid));
  }

  Future<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<RegistrationState> emit) async {
    final user = User.fromControllers(event.controllers);

    //TODO add user to hive here

    emit(UserCreatedSuccessfullyState(userId: user.id));
  }
}
