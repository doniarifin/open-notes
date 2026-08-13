import 'package:flutter/material.dart';
import 'package:open_notes/data/repository/note_repository.dart';
import 'package:open_notes/models/note.dart';
import 'package:open_notes/widgets/edit_note.dart';

class NoteScreen extends StatefulWidget{
  const NoteScreen({
    super.key,
    required this.note,
    required this.title
  });

  final Note? note;
  final String title;

  @override
  State<StatefulWidget> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen>{
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descController.text = widget.note!.description;
    }

    super.initState();
  }

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

  void _deleteNotes() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete note?'),
        content: const Text('This note will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await NoteRepository.deleteNotes(widget.note!);
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
          if (widget.note?.id != null)
            IconButton(
              onPressed: () {
                _deleteNotes();
              }, 
              icon: Icon(Icons.delete)
            ),
          IconButton(
              onPressed: () {
                _saveNotes();
              },
              icon: Icon(Icons.done)
          ),
        ],
      ),
      body: EditNote(titleController: _titleController, descController: _descController)
    );
  }
}