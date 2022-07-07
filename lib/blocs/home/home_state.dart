import 'package:auth_test_project/models/brewery.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends HomeState {}

class LoadingState extends HomeState {}

class UserLoadedState extends HomeState {}

class DataLoadedState extends HomeState {
  DataLoadedState({required this.breweries});
  final List<Brewery> breweries;

  @override
  List<Object> get props => [breweries];
}
