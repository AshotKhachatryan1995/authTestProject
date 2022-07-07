import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class ButtonState extends LoginState {
  ButtonState({required this.isActive});
  final bool isActive;

  @override
  List<Object> get props => [isActive];
}

class UserSignInSuccessfullyState extends LoginState {}

class UserSignInInvalidState extends LoginState {}
