import 'package:auth_test_project/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends RegistrationState {}

class LoadingState extends RegistrationState {}

class ButtonState extends RegistrationState {
  ButtonState({required this.isActive});
  final bool isActive;

  @override
  List<Object> get props => [isActive];
}

class CreateNewUserState extends RegistrationState {
  CreateNewUserState({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class UserCreatedSuccessfullyState extends RegistrationState {}

class UserCreateInvalidState extends RegistrationState {}

class UserAlreadyExists extends RegistrationState {}
