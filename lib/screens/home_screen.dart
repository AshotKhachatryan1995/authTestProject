import 'package:auth_test_project/blocs/authentication/authentication_bloc.dart';
import 'package:auth_test_project/blocs/authentication/authentication_event.dart';
import 'package:auth_test_project/blocs/home/home_bloc.dart';
import 'package:auth_test_project/blocs/home/home_event.dart';
import 'package:auth_test_project/models/user.dart';
import 'package:auth_test_project/shared/bottom_navigation_widget.dart';
import 'package:auth_test_project/shared/centered_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;
  User? get _user => _homeBloc.user;

  final ValueNotifier<int> _selectedNavItemIndex = ValueNotifier(0);
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _homeBloc = HomeBloc()..add(LoadUserEvent());
  }

  @override
  void dispose() {
    _selectedNavItemIndex.dispose();
    _pageController.dispose();
    _homeBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: BlocProvider<HomeBloc>(
            create: (context) => _homeBloc,
            child: ValueListenableBuilder(
                valueListenable: _selectedNavItemIndex,
                builder: (context, int index, child) => Scaffold(
                    backgroundColor: Colors.white,
                    bottomNavigationBar: BottomNavigationWidget(
                      index: index,
                      onTap: _onTap,
                    ),
                    body: PageView.builder(
                        controller: _pageController,
                        itemCount: NavigationType.values.length,
                        itemBuilder: _itemBuilder,
                        onPageChanged: (index) =>
                            _selectedNavItemIndex.value = index)))));
  }

  Widget _itemBuilder(context, index) {
    if (NavigationType.home.index == index) {
      return const Center(child: Text('Api page'));
    }

    if (NavigationType.profile.index == index) {
      final name = _user?.name;

      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Welcome $name'),
            CenteredButtonWidget(
              title: 'Log Out',
              onPressed: _onLogOut,
            )
          ]);
    }

    return const SizedBox.shrink();
  }
}

extension _HomeScreenStateAddition on _HomeScreenState {
  void _onTap(int index) {
    _selectedNavItemIndex.value = index;
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  void _onLogOut() {
    BlocProvider.of<AuthenticationBLoc>(context).add(UserLogOutEvent());
  }
}

enum NavigationType { home, profile }
