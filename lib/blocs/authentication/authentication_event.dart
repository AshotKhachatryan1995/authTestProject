import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends AuthenticationEvent {}

class AppStartedEvent extends AuthenticationEvent {}

class AddNewUserEvent extends AuthenticationEvent {
  const AddNewUserEvent({required this.userId});
  final String userId;

  @override
  List<Object> get props => [userId];
}
