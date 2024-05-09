import 'package:equatable/equatable.dart';
import 'package:sdealsidentification/view/add_todo/add_todo_bloc/add_todo_bloc.dart';

import '../../../data/models/todo.dart';

abstract class AddTodoEvent extends Equatable {
  const AddTodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodoInitialEvent extends AddTodoEvent {}

class AddTodoButtonPressed extends AddTodoEvent {
  final Todo todo;

  const AddTodoButtonPressed({required this.todo});

  @override
  List<Object> get props => [todo];
}
