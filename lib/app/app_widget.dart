import 'package:flutter/material.dart';
import 'package:notesapp/app/data/repositories/theme_nofier.dart';
import 'package:notesapp/routes.g.dart';
import 'package:provider/provider.dart'; // Para gerenciar o estado do tema
import 'package:routefly/routefly.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeManager(), // Provedor do ThemeManager
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: themeManager.currentTheme, // Use currentTheme aqui
            routerConfig: Routefly.routerConfig(
              routes: routes,
              initialPath: routePaths.splash,
            ),
          );
        },
      ),
    );
  }
}
