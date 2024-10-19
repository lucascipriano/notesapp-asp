import 'package:asp/asp.dart';
import 'package:notesapp/app/interactor/models/notes_model.dart';

final todoState = atom<List<NotesModel>>([
  NotesModel(
      id: 1,
      title: 'Titulo 1',
      content:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
]);
