import 'package:flutter/material.dart';
import 'package:notesapp/app/app_widget.dart';
import 'package:notesapp/app/injector.dart';

void main() {
  registerInstances();
  runApp(const AppWidget());
}
