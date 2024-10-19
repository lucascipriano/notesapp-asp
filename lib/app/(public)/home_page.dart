import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp/app/interactor/actions/notes_actions.dart';
import 'package:notesapp/app/interactor/atom/notes_atom.dart';
import 'package:notesapp/app/theme/theme_constants.dart';
import 'package:notesapp/app/theme/theme_manager.dart';

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
          final notes = todoState.state; // Acesse o estado das notas
          return notes.isEmpty
              ? _buildEmptyNotesBody()
              : _buildNotesBody(notes);
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
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

Widget _buildNotesBody(List notes) {
  return ListView.builder(
    itemCount: notes.length,
    itemBuilder: (_, index) {
      final note = notes[index];
      // Aqui você pode renderizar o seu note como desejar
      return ListTile(
        title: Text(
          note.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Exiba o título da nota
        subtitle: Text(note.content), // Exiba o conteúdo da nota, se disponível
        onTap: () {
          // Aqui você pode adicionar a lógica para abrir uma nota, se necessário
        },
      );
    },
  );
}
