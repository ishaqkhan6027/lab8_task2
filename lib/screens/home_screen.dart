import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_82/screens/home_screen.dart';
import 'package:flutter_application_82/models/providers/task_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        taskProvider.addTask(value);
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Add a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final textController = TextEditingController();
                    if (textController.text.isNotEmpty) {
                      taskProvider.addTask(textController.text);
                      textController.clear();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) {
                      taskProvider.toggleTaskStatus(index);
                    },
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
