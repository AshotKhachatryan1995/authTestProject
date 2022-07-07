import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends AuthenticationState {}

class LoadingState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {}

class UnAuthenticatedState extends AuthenticationState {}
