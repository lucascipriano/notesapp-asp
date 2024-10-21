import 'package:asp/asp.dart';
import 'package:notesapp/app/injector.dart';
import 'package:notesapp/app/interactor/atom/notes_atom.dart';
import 'package:notesapp/app/interactor/models/notes_model.dart';
import 'package:notesapp/app/interactor/repositories/note_repository.dart';

final fetchnotes = atomAction((set) async {
  final repository = injector.get<NoteRepository>();
  final todos = await repository.getAll();
  set(todoState, todos);
});

final putAction = atomAction1<NotesModel>((set, model) async {
  final repository = injector.get<NoteRepository>();

  // final currentTodos = todoState.state;
  if (model.id == -1) {
    await repository.inset(model);
  } else {
    await repository.update(model);
  }
  // reload list
  fetchnotes();
});

final deleteAction = atomAction1<int>((set, id) async {
  final repository = injector.get<NoteRepository>();
  await repository.delete(id);
  // reload list
  fetchnotes();
});
