import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../cubit/todo_cubit.dart';
import '../widgets/todo_filter_tabs.dart';
import '../widgets/todo_item_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().loadTodos();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showEditDialog(TodoCubit cubit, todo) {
    final editController = TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Todo"),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(hintText: "Update title"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              cubit.editTodo(todo, editController.text);
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodoCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text("To-Do App")),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// ADD TODO
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: "Enter a new task...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        cubit.addNewTodo(_controller.text);
                        _controller.clear();
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// FILTER
                TodoFilterTabs(
                  selected: state.filter,
                  onChanged: cubit.changeFilter,
                ),

                const SizedBox(height: 12),

                /// LIST
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state.filteredTodos.isEmpty
                      ? const Center(child: Text("No todos found"))
                      : ListView.builder(
                          itemCount: state.filteredTodos.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final todo = state.filteredTodos[index];
                            return TodoItemTile(
                              todo: todo,
                              onToggle: () => cubit.toggleTodoStatus(todo.id),
                              onDelete: () => cubit.removeTodo(todo.id),
                              onEdit: () => _showEditDialog(cubit, todo),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
