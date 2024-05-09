import 'package:equatable/equatable.dart';
import 'package:sdealsidentification/view/list_todos/list_bloc/list_todo_bloc.dart';

import 'package:sdealsidentification/data/models/todo.dart';


abstract class  ListTodoState extends Equatable {
  const ListTodoState();


  @override
  List<Object> get props => [];
}

final class ListTodoInitialState extends ListTodoState {}

class LoadingListTodosState extends ListTodoState {}

class ListTodosSuccesState extends ListTodoState {
  final List<Todo> todos;

  const ListTodosSuccesState({required this.todos});

  @override
  List<Object> get props => [todos];
}

class ListTodosErrorState extends ListTodoState {
  final String message;

  const ListTodosErrorState({ required this.message});

  @override
  List<Object> get props => [message];
}