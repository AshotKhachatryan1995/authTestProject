import 'package:auth_test_project/blocs/authentication/authentication_event.dart';
import 'package:auth_test_project/blocs/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBLoc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBLoc() : super(InitialState()) {
    on<AppStartedEvent>(_onAppStartedEvent);
  }

  Future<void> _onAppStartedEvent(
      AppStartedEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());

    emit(UnAuthenticatedState());
  }
}
