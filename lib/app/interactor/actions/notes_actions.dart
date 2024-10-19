import 'package:asp/asp.dart';
import 'package:notesapp/app/interactor/atom/notes_atom.dart';
import 'package:notesapp/app/interactor/models/notes_model.dart';

final fetchnotes = atomAction((set) async {
  todoState.addListener(() {
    todoState.state;
  });
});
var _autoIncrement = 1; // Começar de 1 ou 0, dependendo da sua lógica

final putAction = atomAction1<NotesModel>((set, model) {
  final currentTodos = todoState.state;

  // Se a nota é nova (id = -1), gere um novo ID incremental
  if (model.id == -1) {
    // Encontre o maior ID atual e incremente para o novo
    if (currentTodos.isNotEmpty) {
      _autoIncrement =
          currentTodos.map((todo) => todo.id).reduce((a, b) => a > b ? a : b) +
              1;
    }

    // Crie a nova nota com o novo ID
    final newTodo = model.copyWith(id: _autoIncrement);

    // Adiciona a nova nota à lista atual
    final updatedTodos = [...currentTodos, newTodo];

    // Atualiza o estado com a nova lista
    set(todoState, updatedTodos);
  } else {
    // Caso contrário, atualiza a nota existente
    final updatedTodos = currentTodos.map((todo) {
      return todo.id == model.id ? model : todo;
    }).toList();

    // Atualiza o estado com a lista modificada
    set(todoState, updatedTodos);
  }
});

final deleteAction = atomAction1<int>((set, id) {
  final currentTodos = todoState.state;

  // Remove o TodoModel com o id especificado
  final updatedTodos = currentTodos.where((todo) => todo.id != id).toList();

  // Atualiza o estado com a lista modificada
  set(todoState, updatedTodos);
});
