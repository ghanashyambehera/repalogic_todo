
import '../entities/todo_entity.dart';


  // This is the abstract class for TodoRepository
  abstract class TodoRepository {

  // Here will get all todos
  Future<List<TodoEntity>> getTodos();
  // Here will add a new todo
  Future<void> addTodo(TodoEntity todo);
  // Here will update the todo by id
  Future<void> updateTodo(TodoEntity todo);
  // Here will delete the todo by id
  Future<void> deleteTodo(String id);
  // Here will get toggle the isCompleted status
  Future<void> toggleTodo(String id);
}