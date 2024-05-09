import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sdealsidentification/data/models/todo.dart';
import 'package:sdealsidentification/data/services/database_service.dart';

import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_event.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_state.dart';

class AddUtilisateurBloc extends Bloc<AddUtilisateurEvent, AddUtilisateurState> {
  final DatabaseService databaseService = DatabaseService.instance;

  AddUtilisateurBloc() : super(AddUtilisateurInitialState()) {
    on<AddUtilisateurEvent>((event, emit) async {

      if(event is AddUtilisateurInitialEvent) {
        emit(AddUtilisateurInitialState());
      }

      if(event is AddUtilisateurButtonPressed) {
        try {
          Todo todo = event.todo;

          await databaseService.insertTodo(todo);
          emit(AddUtilisateurSuccessState());
        } catch (e) {
          emit(const AddUtilisateurErrorState(message: 'Une erreur est surveneue'));
        }
      }
    });
  }
}