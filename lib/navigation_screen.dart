import 'package:auth_test_project/blocs/authentication/authentication_bloc.dart';
import 'package:auth_test_project/blocs/authentication/authentication_event.dart';
import 'package:auth_test_project/blocs/authentication/authentication_state.dart';
import 'package:auth_test_project/screens/home_screen.dart';
import 'package:auth_test_project/screens/registration_screen.dart';
import 'package:auth_test_project/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late final AuthenticationBLoc _authBloc;

  @override
  void initState() {
    super.initState();

    _authBloc = AuthenticationBLoc()..add(AppStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBLoc>(
        create: (context) => _authBloc,
        child: BlocBuilder<AuthenticationBLoc, AuthenticationState>(
            builder: (context, state) => _materialApp(state)));
  }

  Widget _materialApp(AuthenticationState state) {
    return Theme(
        data: ThemeData.light(),
        child: MaterialApp(
            home: _mainRoute(state), onGenerateRoute: (settings) {}));
  }

  Widget _mainRoute(AuthenticationState state) {
    if (state is UnAuthenticatedState) {
      return const RegistrationScreen();
    }

    if (state is AuthenticatedState) {
      return const HomeScreen();
    }

    return const LoadingWidget();
  }
}
