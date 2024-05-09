import 'package:equatable/equatable.dart';

abstract class ListTodoEvent extends Equatable {
  const ListTodoEvent();

  @override
  List<Object> get props => [];

}

class FetchListTodoEvent extends ListTodoEvent {}
