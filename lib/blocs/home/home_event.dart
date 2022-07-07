import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends HomeEvent {}

class LoadUserEvent extends HomeEvent {}
