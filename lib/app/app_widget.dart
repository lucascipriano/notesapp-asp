import 'package:flutter/material.dart';
import 'package:notesapp/app/theme/theme_constants.dart';
import 'package:notesapp/app/theme/theme_manager.dart';
import 'package:notesapp/routes.g.dart';
import 'package:routefly/routefly.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

ThemeManager _themeManager = ThemeManager();

class _AppWidgetState extends State<AppWidget> {
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.splash,
      ),
    );
  }
}
