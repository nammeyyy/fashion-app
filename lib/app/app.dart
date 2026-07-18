import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import 'navigation/navigation_shell.dart';
import 'theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.initialRoute});

  final String? initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute ??
          (FirebaseAuth.instance.currentUser == null ? '/welcome' : '/home'),
      routes: {
        '/home': (_) => const MainPage(),
        '/welcome': (_) => const WelcomePage(),
        '/login': (_) => const LoginPage(),
      },
      title: 'Fashion Lifestyle App',
      theme: AppTheme.light,
    );
  }
}
