import 'package:equatable/equatable.dart';
import 'package:sdealsidentification/data/models/prestataire.dart';
import 'package:sdealsidentification/view/add_todo/add_todo_bloc/add_todo_bloc.dart';

import '../../../data/models/todo.dart';
import '../../../data/models/utilisateur.dart';

import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_bloc.dart';

abstract class AddUtilisateurEvent extends Equatable {
  const AddUtilisateurEvent();

  @override
  List<Object> get props => [];
}

class LoadGroupeSelectFieldData extends AddUtilisateurEvent {}

class LoadCategorieSelectFieldData extends AddUtilisateurEvent {
  final String nomgroupe;

  const LoadCategorieSelectFieldData({required this.nomgroupe});

  @override
  List<Object> get props => [nomgroupe];

}

class LoadServiceSelectFieldData extends AddUtilisateurEvent {
  final String nomcategorie;

  const LoadServiceSelectFieldData({required this.nomcategorie});

  @override
  List<Object> get props => [nomcategorie];

}

class AddUtilisateurButtonPressed extends AddUtilisateurEvent {
  final Utilisateur utilisateur;
  final Prestataire prestataire;

  const AddUtilisateurButtonPressed({
     required this.utilisateur,
    required this.prestataire,
  });

  @override
  List<Object> get props => [utilisateur, prestataire ];
}

class CameraCapture extends AddUtilisateurEvent {}

class GalleryPicker extends AddUtilisateurEvent {
  final int numeroPicture;
  const GalleryPicker({required this.numeroPicture});
  @override
  List<Object> get props => [numeroPicture];
}