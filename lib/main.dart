import 'package:flutter/material.dart';
import 'package:uas_pemmob/auth/presentation/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_pemmob/main_menu/presentation/pages/detail_shoes.dart';
import 'package:uas_pemmob/main_menu/presentation/pages/main_menu.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.figtreeTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenu(),
        '/login': (context) => const LoginPage(),
        '/detail_shoes': (context) => DetailShoes(),
      },
    );
  }
}
