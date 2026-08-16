import 'package:flutter/material.dart';
import 'package:open_notes/screens/home_screen.dart';
import 'package:open_notes/screens/setting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'Open Notes';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 255, 171, 145)),
      ),
      home: HomeScreen(title: title),
      routes: {
        '/setting': (context) => SettingScreen()
      },
    );
  }
}
