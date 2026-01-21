import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entities/todo_entity.dart';

import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/toggle_todo.dart';
import '../../domain/usecases/update_todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;
  final ToggleTodo toggleTodo;

  TodoCubit({
    required this.getTodos,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
    required this.toggleTodo,
  }) : super(TodoState.initial());

  // Load all todos from the repository
  Future<void> loadTodos() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      // Fetch todos using the getTodos use case
      final todos = await getTodos();
      emit(state.copyWith(todos: todos, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
  // Add a new todo to the repository
  Future<void> addNewTodo(String title) async {
    if (title.trim().isEmpty) return;

    // Create a new TodoEntity
    final todo = TodoEntity(
      id: const Uuid().v4(),
      title: title.trim(),
      isCompleted: false,
    );

    // Add the todo using the addTodo use case
    await addTodo(todo);
    // Reload the todos
    await loadTodos();
  }
  // Edit an existing todo in the repository
  Future<void> editTodo(TodoEntity todo, String newTitle) async {
    if (newTitle.trim().isEmpty) return;

    final updated = todo.copyWith(title: newTitle.trim());
    // Update the todo using the updateTodo use case
    await updateTodo(updated);
    // Reload the todos
    await loadTodos();
  }

  // Remove a todo from the repository
  Future<void> removeTodo(String id) async {
    // Delete the todo using the deleteTodo use case
    await deleteTodo(id);
    // Reload the todos
    await loadTodos();
  }
   // Toggle the completion status of a todo
  Future<void> toggleTodoStatus(String id) async {
    // Toggle the todo using the toggleTodo use case
    await toggleTodo(id);
    // Reload the todos
    await loadTodos();
  }
  // Change the current filter for displaying todos
  void changeFilter(TodoFilter filter) {
    emit(state.copyWith(filter: filter));
  }
}