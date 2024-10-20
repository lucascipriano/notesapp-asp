import 'package:notesapp/app/interactor/models/notes_model.dart';

class NoteAdapater {
  static Map<String, dynamic> toMap(NotesModel note) {
    return {
      'id': note.id,
      'title': note.title,
      'content': note.content,
    };
  }

  static NotesModel fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
