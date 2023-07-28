import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hub_control/pages/schedule_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'first_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  List pages =[
    FirstPage(),
    Container(child: Center(child: Text("Next Page")),),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    void onTapNav(int index){
      setState(() {
        _selectedIndex = index;
      });
    }
    return  Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffF94892),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar),label: "calender"),
        ],
      ),
    );
  }


}


