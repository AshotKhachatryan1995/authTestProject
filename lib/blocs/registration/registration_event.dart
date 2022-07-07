import 'package:auth_test_project/controllers/registration_controllers.dart';
import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends RegistrationEvent {}

class TextFieldValueChangedEvent extends RegistrationEvent {
  const TextFieldValueChangedEvent({required this.controllers});
  final RegistrationControllers controllers;

  @override
  List<Object> get props => [controllers];
}

class CreateUserEvent extends RegistrationEvent {
  const CreateUserEvent({required this.controllers});
  final RegistrationControllers controllers;

  @override
  List<Object> get props => [controllers];
}
