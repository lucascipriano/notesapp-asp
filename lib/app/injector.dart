import 'package:auto_injector/auto_injector.dart';
import 'package:notesapp/app/data/repositories/shared_todo_respostory.dart';
import 'package:notesapp/app/interactor/repositories/note_repository.dart';
import 'package:notesapp/app/theme/theme_manager.dart';

final injector = AutoInjector();

void registerInstances() {
  injector.add<NoteRepository>(SharedTodoRespostory.new);
  injector.add<ThemeManager>(ThemeManager.new);
  injector.commit();
}
