import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_bloc.dart';

abstract class AddUtilisateurState extends Equatable {
  const AddUtilisateurState();

  @override
  List<Object> get props => [];
}

class AddUtilisateurInitialState extends AddUtilisateurState {}

class LoadingAddUtilisateurState extends AddUtilisateurState {}

class AddUtilisateurSuccessState extends AddUtilisateurState {}

class AddUtilisateurErrorState extends AddUtilisateurState {
  final String message;
  const AddUtilisateurErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ImagePicked extends AddUtilisateurState {
  final File photoprofil;

  const ImagePicked(this.photoprofil);

  @override
  List<Object> get props => [photoprofil];
}

class FormSubmissionError extends AddUtilisateurState  {
  final String error;

  FormSubmissionError(this.error);

  @override
  List<Object> get props => [error];
}

