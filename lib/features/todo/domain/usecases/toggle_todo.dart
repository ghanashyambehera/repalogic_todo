import '../repositories/todo_repository.dart';

class ToggleTodo {
  final TodoRepository repo;
  ToggleTodo(this.repo);

  Future<void> call(String id) => repo.toggleTodo(id);
}