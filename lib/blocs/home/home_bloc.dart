import 'package:auth_test_project/blocs/home/home_event.dart';
import 'package:auth_test_project/blocs/home/login_state.dart';
import 'package:auth_test_project/models/user.dart';
import 'package:auth_test_project/preferance/shared_preferance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<LoadUserEvent>(_onLoadUserEvent);
  }

  User? _user;
  User? get user => _user;

  final _sharedPrefs = SharedPrefs();

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
}
