part of 'todo_cubit.dart';


class TodoState extends Equatable {
  final List<TodoEntity> todos;
  final TodoFilter filter;
  final bool isLoading;
  final String? error;

  const TodoState({
    required this.todos,
    required this.filter,
    required this.isLoading,
    this.error,
  });

  factory TodoState.initial() {
    return const TodoState(
      todos: [],
      filter: TodoFilter.all,
      isLoading: false,
      error: null,
    );
  }

  TodoState copyWith({
    List<TodoEntity>? todos,
    TodoFilter? filter,
    bool? isLoading,
    String? error,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<TodoEntity> get filteredTodos {
    switch (filter) {
      case TodoFilter.active:
        return todos.where((e) => !e.isCompleted).toList();
      case TodoFilter.completed:
        return todos.where((e) => e.isCompleted).toList();
      case TodoFilter.all:
      default:
        return todos;
    }
  }

  @override
  List<Object?> get props => [todos, filter, isLoading, error];
}