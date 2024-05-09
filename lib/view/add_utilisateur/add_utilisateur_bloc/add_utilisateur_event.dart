import 'package:equatable/equatable.dart';
import 'package:sdealsidentification/view/add_todo/add_todo_bloc/add_todo_bloc.dart';

import '../../../data/models/todo.dart';

abstract class AddUtilisateurEvent extends Equatable {
  const AddUtilisateurEvent();

  @override
  List<Object> get props => [];
}

class AddUtilisateurInitialEvent extends AddUtilisateurEvent {}

class AddUtilisateurButtonPressed extends AddUtilisateurEvent {
  final Todo todo;

  const AddUtilisateurButtonPressed({required this.todo});

  @override
  List<Object> get props => [todo];
}
