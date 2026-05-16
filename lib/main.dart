import 'package:flutter/material.dart';
import 'pages/main_menu_page.dart';

void main() {
  runApp(const BotoneraApp());
}

class BotoneraApp extends StatelessWidget {
  const BotoneraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenuPage(),
    );
  }
}
