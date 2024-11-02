import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/app/data/repositories/theme_nofier.dart';
import 'package:notesapp/routes.g.dart';
import 'package:provider/provider.dart'; // Para gerenciar o estado do tema
import 'package:lottie/lottie.dart';
import 'package:notesapp/app/interactor/actions/notes_actions.dart';
import 'package:notesapp/app/interactor/atom/notes_atom.dart';
import 'package:notesapp/app/interactor/models/notes_model.dart';
import 'package:routefly/routefly.dart';

bool isSelected = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchnotes(); // Carrega as notas quando a página é inicializada
  }

  @override
  Widget build(BuildContext context) {
    return const HomeContent(); // Apenas retorna o HomeContent
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier =
        Provider.of<ThemeManager>(context); // Acessa o ThemeManager

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(
              themeNotifier.isDarkTheme
                  ? Icons.wb_sunny
                  : Icons.nights_stay, // Alterna o ícone com base no tema
            ),
            onPressed: () {
              themeNotifier.toggleTheme(); // Alterna o tema
            },
          ),
        ],
      ),
      body: AtomBuilder(
        builder: (_, get) {
          final notes = get(todoState);
          if (notes.isEmpty) {
            return _buildEmptyNotesBody();
          } else {
            return _buildNotesBody(context, notes);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          final newNote = NotesModel(id: -1, title: '', content: '');
          final result = await Routefly.push(routePaths.editNote, arguments: {
            'note': newNote, // Passando a nova nota como argumento
          });
          if (result != null) {
            putAction(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget _buildEmptyNotesBody() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          width: 400,
          height: 400,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Text(
                  'Create your first note!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: Lottie.asset(
                  'lottie/empty.json',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildNotesBody(BuildContext context, List<NotesModel> notes) {
  return ListView.builder(
    itemCount: notes.length,
    itemBuilder: (_, index) {
      final note = notes[index];
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text(
            note.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(note.content),
          onTap: () {
            Routefly.push(
              routePaths.editNote,
              arguments: {'note': note}, // Passando a nota como argumento
            );
          },
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _confirmDelete(context, note.id);
            },
          ),
        ),
      );
    },
  );
}

void _confirmDelete(BuildContext context, int noteId) async {
  // Exibe o diálogo de confirmação
  await showDialog<bool>(
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
            deleteAction(noteId);
            Navigator.of(context).pop(true);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
