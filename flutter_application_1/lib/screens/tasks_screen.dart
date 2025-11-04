import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add({
          'title': _controller.text,
          'done': false,
        });
        _controller.clear();
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
      _tasks.sort((a, b) => a['done'] == b['done'] ? 0 : (a['done'] ? 1 : -1));
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'To-Do App',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          // 👥 Collaborators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
                radius: 22,
              ),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=2'),
                radius: 22,
              ),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                radius: 22,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Task input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter a task',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _addTask,
                child: const Text('Add'),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Task list
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task['done'],
                    onChanged: (_) => _toggleTask(index),
                  ),
                  title: Text(
                    task['title'],
                    style: TextStyle(
                      fontSize: 16,
                      decoration: task['done']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task['done'] ? Colors.grey : Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTask(index),
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
