import 'package:flutter/material.dart';
import 'package:notesapp/app/interactor/actions/notes_actions.dart';
import 'package:notesapp/app/interactor/models/notes_model.dart';

class EditNotePage extends StatelessWidget {
  const EditNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Utilize ModalRoute para acessar as configurações da rota
    final settings = ModalRoute.of(context);
    // Extraia os argumentos como um Map<String, dynamic>
    final args = settings?.settings.arguments as Map<String, dynamic>?;
    // Verifique se args não é nulo e extraia a nota
    final note = args != null ? args['note'] as NotesModel? : null;

    // Se note for null, você pode lidar com isso como preferir
    if (note == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No note provided')),
      );
    }

    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            note.title.isEmpty ? 'New Note' : 'Edit Note'), // Título dinâmico
        actions: [
          IconButton(
            onPressed: () {
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
              final confirm = await _alertDelete(context, note.id);
              if (confirm == true) {
                deleteAction(note.id);
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
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
                    const Color.fromARGB(255, 120, 119, 117).withAlpha(10),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(0),
                ),
                hintText: "Write Notes",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool?> _alertDelete(BuildContext context, int noteId) async {
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
            Navigator.of(context).pop(true);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );

  return confirm; // Retorna true ou false dependendo da ação
}
