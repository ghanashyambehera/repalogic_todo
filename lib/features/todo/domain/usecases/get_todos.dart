import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class GetTodos {
  final TodoRepository repo;
  GetTodos(this.repo);

  Future<List<TodoEntity>> call() => repo.getTodos();
}