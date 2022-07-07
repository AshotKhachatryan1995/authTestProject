import 'package:auth_test_project/blocs/authentication/authentication_bloc.dart';
import 'package:auth_test_project/blocs/authentication/authentication_event.dart';
import 'package:auth_test_project/blocs/home/home_bloc.dart';
import 'package:auth_test_project/blocs/home/home_event.dart';
import 'package:auth_test_project/blocs/home/home_state.dart';
import 'package:auth_test_project/models/brewery.dart';
import 'package:auth_test_project/models/user.dart';
import 'package:auth_test_project/repositories/api_repository_impl.dart';
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
  final ValueNotifier<List<Brewery>> _breweriesNotifier = ValueNotifier([]);

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _homeBloc = HomeBloc(ApiRepositoryImpl())
      ..add(LoadUserEvent())
      ..add(LoadDataEvent());
  }

  @override
  void dispose() {
    _selectedNavItemIndex.dispose();
    _breweriesNotifier.dispose();
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
            child: BlocListener<HomeBloc, HomeState>(
                listener: _listener,
                child: ValueListenableBuilder(
                    valueListenable: _selectedNavItemIndex,
                    builder: (context, int index, child) => Scaffold(
                        backgroundColor: Colors.white,
                        bottomNavigationBar: BottomNavigationWidget(
                          index: index,
                          onTap: _onTap,
                        ),
                        body: SafeArea(
                            child: PageView.builder(
                                controller: _pageController,
                                itemCount: NavigationType.values.length,
                                itemBuilder: _itemBuilder,
                                onPageChanged: (index) =>
                                    _selectedNavItemIndex.value = index)))))));
  }

  Widget _itemBuilder(context, index) {
    if (NavigationType.home.index == index) {
      return ValueListenableBuilder(
          valueListenable: _breweriesNotifier,
          builder: (contex, List<Brewery> items, child) => ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                final brewery = items[index];

                return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide())),
                    child: Row(
                      children: [
                        Expanded(child: Text(brewery.name)),
                        const SizedBox(width: 15),
                        Expanded(child: Text(brewery.state ?? 'state')),
                        const SizedBox(width: 15),
                        Expanded(
                            child: Text(brewery.postalCode ?? '00',
                                overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: 15),
                        Expanded(
                            child: Text(brewery.phoneNumber ?? '+374',
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ));
              }));
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

  void _onLogOut() =>
      BlocProvider.of<AuthenticationBLoc>(context).add(UserLogOutEvent());

  void _listener(context, state) {
    if (state is DataLoadedState) {
      _breweriesNotifier.value = state.breweries;
    }
  }
}

enum NavigationType { home, profile }
