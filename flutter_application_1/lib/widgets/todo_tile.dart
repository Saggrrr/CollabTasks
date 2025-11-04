import 'package:flutter/material.dart';
import '../models/todo.dart';

class ToDoTile extends StatelessWidget {
  final ToDo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const ToDoTile({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (value) => onToggle(),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
