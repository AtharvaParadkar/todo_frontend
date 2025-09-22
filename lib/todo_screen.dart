import 'package:flutter/material.dart';
import 'package:todo_frontend/api_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final ApiService api = ApiService();
  List todos = [];
  final _controller = TextEditingController();

  Future<void> _loadTodos() async {
    final data = await api.getTodos();
    setState(() => todos = data);
  }

  Future<void> _addTodo() async {
    if (_controller.text.isNotEmpty) {
      await api.addTodo(_controller.text);
      _controller.clear();
      _loadTodos();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Todos")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(labelText: "New Todo"))),
                IconButton(onPressed: _addTodo, icon: const Icon(Icons.add))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo["text"]),
                  trailing: Icon(
                    todo["completed"] ? Icons.check_circle : Icons.circle_outlined,
                    color: todo["completed"] ? Colors.green : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
