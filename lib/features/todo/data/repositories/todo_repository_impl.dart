import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource local;

  TodoRepositoryImpl(this.local);

  @override
  Future<List<TodoEntity>> getTodos() async {
    return local.getTodos();
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    await local.addTodo(TodoModel.fromEntity(todo));
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    await local.updateTodo(TodoModel.fromEntity(todo));
  }

  @override
  Future<void> deleteTodo(String id) async {
    await local.deleteTodo(id);
  }

  @override
  Future<void> toggleTodo(String id) async {
    await local.toggleTodo(id);
  }
}