import 'package:flutter/material.dart';
import 'package:todo_frontend/api_service.dart';
import 'package:todo_frontend/todo_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String message = "";
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login / Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _usernameController, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            ElevatedButton(onPressed: _register, child: const Text("Register")),
            const SizedBox(height: 20),
            Text(message, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  Future<void> _login () async {
    final res = await api.login(_usernameController.text, _passwordController.text);
    setState(() {
      message = res ?? "";
    });
    if (res == "Login Successful!!") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> TodoScreen()));
    }
  }

  Future<void> _register () async {
    final res = await api.register(_usernameController.text, _passwordController.text);
    setState(() {
      message = res ?? "";
    });
  }

}
