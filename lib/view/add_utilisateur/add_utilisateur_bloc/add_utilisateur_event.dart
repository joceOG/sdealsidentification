import 'package:equatable/equatable.dart';
import 'package:sdealsidentification/view/add_todo/add_todo_bloc/add_todo_bloc.dart';

import '../../../data/models/todo.dart';
import '../../../data/models/utilisateur.dart';

import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_bloc.dart';

abstract class AddUtilisateurEvent extends Equatable {
  const AddUtilisateurEvent();

  @override
  List<Object> get props => [];
}

class AddUtilisateurInitialEvent extends AddUtilisateurEvent {}

class AddUtilisateurButtonPressed extends AddUtilisateurEvent {
  final Utilisateur utilisateur;

  const AddUtilisateurButtonPressed({required this.utilisateur});

  @override
  List<Object> get props => [utilisateur];
}

class CameraCapture extends AddUtilisateurEvent {}
class GalleryPicker extends AddUtilisateurEvent {}
class FetchListGroupeEvent extends AddUtilisateurEvent {}