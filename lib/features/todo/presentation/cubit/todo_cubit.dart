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

  Future<void> loadTodos() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final todos = await getTodos();
      emit(state.copyWith(todos: todos, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> addNewTodo(String title) async {
    if (title.trim().isEmpty) return;

    final todo = TodoEntity(
      id: const Uuid().v4(),
      title: title.trim(),
      isCompleted: false,
    );

    await addTodo(todo);
    await loadTodos();
  }

  Future<void> editTodo(TodoEntity todo, String newTitle) async {
    if (newTitle.trim().isEmpty) return;

    final updated = todo.copyWith(title: newTitle.trim());
    await updateTodo(updated);
    await loadTodos();
  }

  Future<void> removeTodo(String id) async {
    await deleteTodo(id);
    await loadTodos();
  }

  Future<void> toggleTodoStatus(String id) async {
    await toggleTodo(id);
    await loadTodos();
  }

  void changeFilter(TodoFilter filter) {
    emit(state.copyWith(filter: filter));
  }
}