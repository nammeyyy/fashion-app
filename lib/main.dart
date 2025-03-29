import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/firebase_options.dart';
import 'package:fashion_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/cart_page.dart';
import 'pages/account_page.dart';
import 'pages/welcome_page.dart';
import 'bottom_nav/bottom_navBar.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;
late final FirebaseFirestore firestore;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
   ); 
   auth = FirebaseAuth.instanceFor(app: app);
   firestore = FirebaseFirestore.instanceFor(app: app);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/home' : '/welcome',
      routes: {
        '/home' : (context) => const MainPage(),
        '/welcome' : (context) => const WelcomePage(),
        '/login' : (context) => const LoginPage()
      },
      title: 'Fashion Lifestyle App',
      theme: ThemeData(
        primaryColor: Color(0xff97C2EC),
        secondaryHeaderColor: Color(0xffAAB8FF),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
      ),
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
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}