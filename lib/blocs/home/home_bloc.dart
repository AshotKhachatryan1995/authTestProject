import 'package:auth_test_project/blocs/home/home_event.dart';
import 'package:auth_test_project/blocs/home/home_state.dart';
import 'package:auth_test_project/models/brewery.dart';
import 'package:auth_test_project/models/user.dart';
import 'package:auth_test_project/preferance/shared_preferance.dart';
import 'package:auth_test_project/repositories/api_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._apiRepositoryImpl) : super(InitialState()) {
    on<LoadUserEvent>(_onLoadUserEvent);
    on<LoadDataEvent>(_onLoadDataEvent);
  }

  User? _user;
  User? get user => _user;

  final _sharedPrefs = SharedPrefs();

  final ApiRepositoryImpl _apiRepositoryImpl;

  Future<void> _onLoadUserEvent(
      LoadUserEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    try {
      var userId = await _sharedPrefs.getString('userId', defaultValue: '');

      final box = await Hive.openBox<User>('users_db');

      _user = box.get(userId);
    } catch (e) {
      throw Exception(e.toString());
    }

    emit(UserLoadedState());
  }

  Future<void> _onLoadDataEvent(
      LoadDataEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());

    final result = await _apiRepositoryImpl.loadData();

    if (result is List<Brewery>) {
      emit(DataLoadedState(breweries: result));
      return;
    }

    emit(InitialState());
  }
}
