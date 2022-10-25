import 'package:flutter/material.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/ui/favorite_page.dart';
import 'package:resto_app/ui/home_page.dart';
import 'package:resto_app/ui/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _navIndex = 0;

  final List<Widget> _listWidget = [
    const HomePage(),
    const FavPage(homePage: HomePage()),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Resto"),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  AppBar appBar(BuildContext context) {
    return AppBar(
        backgroundColor: secondaryColor,
        foregroundColor: primaryColor,
        title: const Text("Favorite"),
      );
  }

  void _onNavButtonTapped(int index) {
    setState(() {
      _navIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _listWidget[_navIndex] == _listWidget[1] ? appBar(context) : null,
      body: _listWidget[_navIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        elevation: 5,
        currentIndex: _navIndex,
        items: _bottomNavBarItems,
        onTap: _onNavButtonTapped,
      ),
    );
  }
}