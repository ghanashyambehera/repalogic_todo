
import '../models/todo_model.dart';

class TodoLocalDataSource {

  final List<TodoModel> _todos = [];

  Future<List<TodoModel>> getTodos() async {
    return List.from(_todos);
  }

  Future<void> addTodo(TodoModel todo) async {
    _todos.add(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    final index = _todos.indexWhere((e) => e.id == todo.id);
    if (index != -1) _todos[index] = todo;
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((e) => e.id == id);
  }

  Future<void> toggleTodo(String id) async {
    final index = _todos.indexWhere((e) => e.id == id);
    if (index != -1) {
      final old = _todos[index];
      _todos[index] = TodoModel(
        id: old.id,
        title: old.title,
        isCompleted: !old.isCompleted,
      );
    }
  }
}