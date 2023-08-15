import 'package:flutter/material.dart';
import 'package:hub_control/pages/schedule_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'first_page.dart';

class HomePage extends StatefulWidget {
  final String userName;
  const HomePage(this.userName, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;
  int _index = 0;
  List<Widget>  _buildScreens() {
    return [
      FirstPage(widget.userName),
       SchedulePage(widget.userName),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: _index == 0 ? const Icon(Icons.home,color: Colors.white) :  const Icon(Icons.home_outlined,color: Colors.white),
        title: ("Home"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: _index == 1 ? const Icon(Icons.calendar_month) : const Icon(Icons.calendar_month_outlined),
        title: ("calender"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }
  @override
  void initState() {
    super.initState();
        _controller = PersistentTabController(initialIndex: _index);

  }
  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        _index = _controller.index;
      });
    });
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: const Color(0xffF94892), // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar :const Color(0xffF94892),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
  }





