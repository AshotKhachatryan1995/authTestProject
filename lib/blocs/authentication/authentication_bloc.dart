import 'package:auth_test_project/blocs/authentication/authentication_event.dart';
import 'package:auth_test_project/blocs/authentication/authentication_state.dart';
import 'package:auth_test_project/preferance/shared_preferance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBLoc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBLoc() : super(InitialState()) {
    on<AppStartedEvent>(_onAppStartedEvent);
    on<UserLogOutEvent>(_onUserLogOutEvent);
  }

  final _sharedPrefs = SharedPrefs();

  Future<void> _onAppStartedEvent(
      AppStartedEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());

    var userId = _sharedPrefs.valueByKey('userId');

    if (userId == null) {
      emit(UnAuthenticatedState());
      return;
    }

    emit(AuthenticatedState());
  }

  Future<void> _onUserLogOutEvent(
      UserLogOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());

    try {
      _sharedPrefs.remove('userId');
    } catch (e) {
      throw Exception(e.toString());
    }
    emit(UnAuthenticatedState());
  }
}
