import 'package:flutter/material.dart';
import 'package:notesapp/app/interactor/actions/notes_actions.dart';
import 'package:notesapp/app/interactor/models/notes_model.dart';
import 'package:routefly/routefly.dart';

class EditNotePage extends StatelessWidget {
  final NotesModel note;

  const EditNotePage({super.key, required this.note});

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

              putAction(updatedNote);

              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () async {
              // Chama o _alertDelet e espera o retorno da confirmação
              final confirm = await _alertDelet(context, note.id);

              // Verifica se o retorno foi true para executar a ação desejada
              if (confirm == true) {
                Routefly.pop(context);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              scrollPadding: const EdgeInsets.only(bottom: 10),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLength: 1000,
              maxLines: 20,
              decoration: InputDecoration(
                fillColor:
                    const Color.fromARGB(255, 120, 119, 117).withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Write Notes",
              ),
            ),
            // Adicione outros elementos de UI se necessário
          ],
        ),
      ),
    );
  }
}

Future<bool?> _alertDelet(BuildContext context, int noteId) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this note?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Fecha o diálogo antes da ação
            Navigator.of(context).pop(true);
            deleteAction(noteId);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );

  return confirm; // Retorna true ou false dependendo da ação
}
