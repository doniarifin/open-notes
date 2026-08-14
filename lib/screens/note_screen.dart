import 'package:flutter/material.dart';
import 'package:open_notes/data/repository/note_repository.dart';
import 'package:open_notes/models/note.dart';
import 'package:open_notes/widgets/edit_note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key, required this.note, required this.title});

  final Note? note;
  final String title;

  @override
  State<StatefulWidget> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
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

  Future<bool> _saveNotes() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Title cannot be empty')));
      return false;
    }

    final note = Note(
      id: widget.note?.id,
      title: title,
      description: _descController.text.trim(),
      createdAt: widget.note?.createdAt ?? DateTime.now(),
    );

    await NoteRepository.saveNotes(note);
    if (mounted) Navigator.pop(context);
    return true;
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final hasChanges =
            (_titleController.text.isNotEmpty && widget.note?.id == null) ||
            ((_titleController.text != widget.note?.title || _descController.text != widget.note?.description) && widget.note?.id != null);

        if (!hasChanges) {
          Navigator.pop(context);
          return;
        }

        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Discard changes?'),
            content: const Text('Unsaved changes will be lost.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Discard'),
              ),
              TextButton(
                onPressed: () async {
                  final dialogContext = context; // context dialog
                    final saved = await _saveNotes();
                    if (saved && dialogContext.mounted) {
                      Navigator.pop(dialogContext); // close dialog
                    }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );

        if (shouldPop == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            // if (widget.note?.id != null)
            //   IconButton(
            //     onPressed: () {
            //       _deleteNotes();
            //     },
            //     icon: Icon(Icons.delete)
            //   ),
            // IconButton(
            //     onPressed: () {
            //       _saveNotes();
            //     },
            //     icon: Icon(Icons.done)
            // ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'save') {
                  _saveNotes();
                } else {
                  _deleteNotes();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'save',
                  child: Row(
                    spacing: 2.0,
                    children: [Icon(Icons.save), Text('Save')],
                  ),
                ),
                if (widget.note?.id != null)
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      spacing: 2.0,
                      children: [Icon(Icons.delete), Text('Delete')],
                    ),
                  ),
              ],
            ),
          ],
        ),
        body: EditNote(
          titleController: _titleController,
          descController: _descController,
        ),
      ),
    );
  }
}
