import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'app_routes.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final rpgTheme = ThemeData(
      primarySwatch: Colors.brown,
      scaffoldBackgroundColor: const Color(0xFFF8F3E5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF6F4E37),
        foregroundColor: Colors.white,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.brown,
        backgroundColor: const Color(0xFFF8F3E5),
        accentColor: const Color(0xFFBCA380),
      ).copyWith(
        secondary: const Color(0xFFD2B48C), 
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Color(0xFF6F4E37), 
        ),
        titleLarge: TextStyle(
          color: Color(0xFF6F4E37),
          fontWeight: FontWeight.bold,
        ),
      ),
        cardColor: const Color(0xFFE6D3B3),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB97A57),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
    );

    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'RPG Builder',
        theme: rpgTheme,
        initialRoute: AppRoutes.login,
        routes: AppRoutes.routes,
      ),
    );
  }
}
