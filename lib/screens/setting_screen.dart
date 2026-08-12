import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.auto_awesome_outlined),
            title: Text('Theme'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('Language'),
            onTap: () {},
          )
        ],
      )
    );
  }
}