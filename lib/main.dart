import 'package:flutter/material.dart';
import 'package:open_notes/screens/home_screen.dart';
import 'package:open_notes/screens/setting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(title: "Open Notes"),
      routes: {
        '/setting': (context) => SettingScreen()
      },
    );
  }
}
