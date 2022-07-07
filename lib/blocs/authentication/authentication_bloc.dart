import 'package:auth_test_project/blocs/authentication/authentication_event.dart';
import 'package:auth_test_project/blocs/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBLoc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBLoc() : super(InitialState()) {
    on<AppStartedEvent>(_onAppStartedEvent);
    on<AddNewUserEvent>(_onAddNewUserEvent);
  }

  Future<void> _onAppStartedEvent(
      AppStartedEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());

    final sharedPrefs = await SharedPreferences.getInstance();
    final userId = sharedPrefs.get('userId');

    if (userId == null) {
      emit(UnAuthenticatedState());
      return;
    }

    emit(AuthenticatedState());
  }

  Future<void> _onAddNewUserEvent(
      AddNewUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());

    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString('userId', event.userId);

    emit(AuthenticatedState());
  }
}
