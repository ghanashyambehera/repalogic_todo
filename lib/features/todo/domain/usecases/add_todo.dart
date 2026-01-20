import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repo;
  AddTodo(this.repo);

  Future<void> call(TodoEntity todo) => repo.addTodo(todo);
}