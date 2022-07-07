import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends AuthenticationEvent {}

class AppStartedEvent extends AuthenticationEvent {}

class UserLogOutEvent extends AuthenticationEvent {}
