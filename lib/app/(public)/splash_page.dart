import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp/routes.g.dart';
import 'package:routefly/routefly.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2300), () {
      Routefly.navigate(routePaths.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Lottie.asset('lottie/hello_animate.json'),
      ),
    );
  }
}
