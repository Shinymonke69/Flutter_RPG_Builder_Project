import 'package:flutter/material.dart';
import 'screens/auth/pages/login_page.dart';
import 'screens/auth/pages/register_page.dart';
import 'screens/character/pages/characters_page.dart'; 

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    home: (context) => const CharactersPage(),
  };
}
