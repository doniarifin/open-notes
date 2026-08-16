import 'package:flutter/material.dart';
import 'package:open_notes/widgets/setting/list_section.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Setting')),
        body: ListView(
          children: [
            ListSection(
              icons: Icons.auto_awesome_outlined,
              position: 'first',
              title: 'Theme',
            ),
            ListSection(
              icons: Icons.language,
              position: 'last',
              title: 'Language',
            ),
          ],
        ),
      ),
    );
  }
}
