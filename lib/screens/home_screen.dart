import 'package:auth_test_project/shared/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _selectedNavItemIndex = ValueNotifier(0);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
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
                    _selectedNavItemIndex.value = index)));
  }
}

Widget _itemBuilder(context, index) {
  if (NavigationType.home.index == index) {
    return const Center(child: Text('Api page'));
  }

  if (NavigationType.profile.index == index) {
    return const Center(child: Text('Profile page'));
  }

  return const SizedBox.shrink();
}

extension _HomeScreenStateAddition on _HomeScreenState {
  void _onTap(int index) {
    _selectedNavItemIndex.value = index;
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}

enum NavigationType { home, profile }
