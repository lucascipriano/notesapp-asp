import 'package:asp/asp.dart';
import 'package:notesapp/app/interactor/atom/notes_atom.dart';

final fetchnotes = atomAction((set) async {
  todoState.addListener(() {
    todoState.state;
  });
});
