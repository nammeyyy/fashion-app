import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/cart_page.dart';
import 'pages/account_page.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion Lifestyle App',
      theme: ThemeData(
        primaryColor: const Color(0xFF79AEB2),
        scaffoldBackgroundColor: const Color(0xFFF5EFE6),
      ),
      home: const WelcomePage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const CartPage(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF79AEB2),
        onTap: _onItemTapped,
      ),
    );
  }
}