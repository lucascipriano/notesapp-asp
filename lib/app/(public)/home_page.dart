import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp/app/interactor/actions/notes_actions.dart';
import 'package:notesapp/app/interactor/atom/notes_atom.dart';
import 'package:notesapp/app/interactor/models/notes_model.dart';
import 'package:notesapp/app/theme/theme_constants.dart';
import 'package:notesapp/app/theme/theme_manager.dart';
import 'package:notesapp/routes.g.dart';
import 'package:routefly/routefly.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

ThemeManager _themeManager = ThemeManager();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _themeManager.addListener(themeListner);
    super.initState();
    fetchnotes();
  }

  @override
  void dispose() {
    _themeManager.removeListener(themeListner);
    super.dispose();
  }

  themeListner() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeData,
      // Se usar const da ruim com switch
      // ignore: prefer_const_constructors
      home: HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  _themeManager.themeData == ThemeMode.dark
                      ? Icons.wb_sunny // Ícone para tema claro
                      : Icons.nights_stay, // Ícone para tema escuro
                ),
                onPressed: () {
                  _themeManager
                      .toggleTheme(_themeManager.themeData == ThemeMode.light);
                },
              ),
            ],
          )
        ],
      ),
      body: AtomBuilder(
        builder: (_, get) {
          final notes = get(todoState); // Obtém a lista atualizada de notas
          if (notes.isEmpty) {
            return _buildEmptyNotesBody(); // Chama a função para notas vazias
          } else {
            return _buildNotesBody(
                context, notes); // Chama a função para exibir as notas
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          final newNote = NotesModel(id: -1, title: '', content: '');
          final result =
              await Routefly.push(routePaths.editNote, arguments: newNote);
          if (result != null) {
            // Aqui, result é a nota que foi salva
            putAction(result); // Adiciona a nova nota ao estado
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
      mainAxisAlignment: MainAxisAlignment.center, // Centraliza o conteúdo
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
        margin: const EdgeInsets.symmetric(
            vertical: 8.0), // Espaçamento vertical entre os itens
        child: ListTile(
          title: Text(
            note.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            note.content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Routefly.push(routePaths.editNote, arguments: note);
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

  // ignore: unused_local_variable
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
            deleteAction(noteId); // Chama a função de exclusão
            Navigator.of(context).pop(true); // Fecha o diálogo após confirmar
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
