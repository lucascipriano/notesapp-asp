import 'package:flutter/material.dart';
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
      body: Center(
        child: Switch(
            value: _themeManager.themeData == ThemeMode.dark,
            onChanged: (value) {
              _themeManager.toggleTheme(value);
            }),
      ),
    );
  }
}
