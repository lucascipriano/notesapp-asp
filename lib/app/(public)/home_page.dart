import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
      body: Column(
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
                      'Create your first note !',
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
                  )
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
