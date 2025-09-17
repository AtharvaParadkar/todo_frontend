
import 'package:flutter/material.dart';
import 'package:todo_frontend/login_screen.dart';

void main () {
  runApp(ToDo());
}

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter + Express",
      home: LoginScreen(),
    );
  }
}
