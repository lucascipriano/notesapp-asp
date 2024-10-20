import 'dart:convert';

import 'package:notesapp/app/data/adapters/note_adapater.dart';
import 'package:notesapp/app/interactor/models/notes_model.dart';
import 'package:notesapp/app/interactor/repositories/note_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _key = "NOTE_LIST";

class SharedTodoRespostory implements NoteRepository {
  @override
  Future<List<NotesModel>> getAll() async {
    final shared = await SharedPreferences.getInstance();
    final json = shared.getString(_key);
    if (json == null) return [];
    final list = jsonDecode(json) as List;
    return list.map((e) => NoteAdapater.fromMap(e)).toList();
  }

  @override
  Future<NotesModel> inset(NotesModel model) async {
    final shared = await SharedPreferences.getInstance();
    final json = shared.getString(_key) ?? '[]';
    final list = jsonDecode(json) as List;
    final id = list.isEmpty ? 1 : list.last['id'] + 1;
    final newModel = model.copyWith(id: id);
    list.add(NoteAdapater.toMap(newModel));
    await shared.setString(_key, jsonEncode(list));
    return newModel;
  }

  @override
  Future<NotesModel> update(NotesModel model) async {
    final shared = await SharedPreferences.getInstance();
    final json = shared.getString(_key) ?? '[]';
    final list = jsonDecode(json) as List;
    final index = list.indexWhere((e) => e['id'] == model.id);
    if (index == -1) throw Exception('Todo not found');
    list[index] = NoteAdapater.toMap(model);
    await shared.setString(_key, jsonEncode(list));
    return model;
  }

  @override
  Future<bool> delete(int id) async {
    final shared = await SharedPreferences.getInstance();
    final json = shared.getString(_key) ?? '[]';
    final list = jsonDecode(json) as List;
    final index = list.indexWhere((e) => e['id'] == id);
    if (index == -1) return false;
    list.removeAt(index);
    await shared.setString(_key, jsonEncode(list));
    return true;
  }
}
