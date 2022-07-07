import 'package:auth_test_project/blocs/sign_up/registration_event.dart';
import 'package:auth_test_project/blocs/sign_up/registration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(InitialState()) {
    on<TextFieldValueChangedEvent>(_onTextFieldValueChangedEvent);
  }

  Future<void> _onTextFieldValueChangedEvent(
      TextFieldValueChangedEvent event, Emitter<RegistrationState> emit) async {
    final controllers = event.controllers;

    final isValid = controllers.areNotEmpty;

    emit(ButtonState(isActive: isValid));
  }
}
