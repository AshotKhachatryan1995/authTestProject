import 'package:auth_test_project/controllers/login_controllers.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends LoginEvent {}

class TextFieldValueChangedEvent extends LoginEvent {
  const TextFieldValueChangedEvent({required this.controllers});
  final LoginControllers controllers;

  @override
  List<Object> get props => [controllers];
}

class UserSignInEvent extends LoginEvent {
  const UserSignInEvent({required this.controllers});
  final LoginControllers controllers;

  @override
  List<Object> get props => [controllers];
}
