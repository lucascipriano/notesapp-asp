import 'package:flutter/material.dart';
import 'package:notesapp/app/interactor/actions/notes_actions.dart';
import 'package:notesapp/app/interactor/models/notes_model.dart';

class EditNotePage extends StatelessWidget {
  final NotesModel note;

  const EditNotePage({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            note.title.isEmpty ? 'New Note' : 'Edit Note'), // Título dinâmico
        actions: [
          IconButton(
            onPressed: () {
              // Obtenha os valores dos campos de texto
              final updatedNote = note.copyWith(
                title: titleController.text,
                content: contentController.text,
              );

              // Chama a ação para salvar a nota
              putAction(updatedNote);

              // Retorna para a página anterior
              Navigator.pop(context); // Retorna a nota atualizada para HomePage
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              deleteAction(note.id);
              Navigator.pop(context);
              // Retorna a nota atualizada para HomePage
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            // Adicione outros elementos de UI se necessário
          ],
        ),
      ),
    );
  }
}
