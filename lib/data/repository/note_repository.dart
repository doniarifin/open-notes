import 'package:open_notes/data/database/db_helper.dart';
import 'package:open_notes/models/note.dart';

class NoteRepository {
  static Future<List<Note>> getAllNotes() async {
    final db = await DbHelper.database;
    final maps = await db.query('notes', orderBy: 'createdAt DESC');
    return maps.map((m) => Note.fromMap(m)).toList();
  }

  static Future<void> saveNotes(Note note) async {
    final db = await DbHelper.database;
    if (note.id == null) {
      await db.insert('notes', note.toMap());
    } else {
      await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    }
  }

  static Future<void> deleteNotes(Note note) async {
    final db = await DbHelper.database;
    await db.delete('notes', where: 'id = ?', whereArgs: [note.id]);
  }

}