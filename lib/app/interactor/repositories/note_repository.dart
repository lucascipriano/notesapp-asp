import 'package:notesapp/app/interactor/models/notes_model.dart';

abstract class NoteRepository {
  Future<List<NotesModel>> getAll();
  Future<NotesModel> inset(NotesModel model);
  Future<NotesModel> update(NotesModel model);
  Future<bool> delete(int id);
}
