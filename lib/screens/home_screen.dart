import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:open_notes/data/repository/note_repository.dart';
import 'package:open_notes/screens/note_screen.dart';
import 'package:open_notes/screens/setting_screen.dart';
import 'package:open_notes/widgets/square_list.dart';

import '../models/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.title
  });

  final String title;

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Note>> _notesFuture;

  @override
  void initState() {
    _loadNoteFuture();
    super.initState();
  }

  void _loadNoteFuture() async {
    _notesFuture = NoteRepository.getAllNotes();
    final notes = await _notesFuture;
    developer.log(notes.toString());
  }


  void _refresh() {
    setState(() {
      _loadNoteFuture();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => SettingScreen())
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
            MaterialPageRoute(builder: (context) => NoteEditScreen(
              title: 'New notes',
              note: null,
            ))
          );
          _refresh();
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Note>>(
        future: _notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center (
              child: Text('no data'),
            );
          }

          final notes = snapshot.data!;
          return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return SquareList(title: note.title, description: note.description);
              },
          );
        },
      ),
    );
  }
}
