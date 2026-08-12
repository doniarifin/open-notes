import 'package:flutter/material.dart';
import 'package:open_notes/data/repository/note_repository.dart';
import 'package:open_notes/models/note.dart';

class NoteEditScreen extends StatefulWidget{
  const NoteEditScreen({
    super.key,
    required this.note,
    required this.title
  });

  final Note? note;
  final String title;

  @override
  State<StatefulWidget> createState() => _NoteEditScreen();
}

class _NoteEditScreen extends State<NoteEditScreen>{
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  late NoteRepository _noteRepository;

  void _saveNotes() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title cannot be empty'))
      );
      return;
    }

    final note = Note(
      id: widget.note?.id,
      title: title,
      description: _descController.text.trim(),
      createdAt: widget.note?.createdAt ?? DateTime.now(),
    );

    await NoteRepository.saveNotes(note);
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                _saveNotes();
              },
              icon: Icon(Icons.done)
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // spacing: 12,
          children: [
            Expanded(
                child: ListView(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder()
                      ),
                    ),
                    Divider(color: Colors.transparent,),
                    TextField(
                      controller: _descController,
                      keyboardType: TextInputType.multiline,
                      // minLines: 3,
                      maxLines: 30,
                      // expands: true,
                      decoration: InputDecoration(
                          hintText: 'Type your notes',
                          border: OutlineInputBorder()
                      ),
                      // scrollPhysics: const BouncingScrollPhysics(),
                    )
                  ],
                )
            )

          ],
        ),
      ),
    );
  }
}