import 'package:flutter/material.dart';
import 'package:notesapp/app/interactor/models/notes_model.dart';

class EditNotePage extends StatelessWidget {
  final NotesModel note;

  const EditNotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: note.title),
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: TextEditingController(text: note.content),
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            // Adicione um botão para salvar ou qualquer outra lógica
          ],
        ),
      ),
    );
  }
}
