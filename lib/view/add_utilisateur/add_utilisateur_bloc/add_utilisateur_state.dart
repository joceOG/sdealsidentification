import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_bloc.dart';

class AddUtilisateurState extends Equatable {
  final XFile? file ;

  const AddUtilisateurState( {
    this.file
});

  AddUtilisateurState copyWith({XFile? file}){
    return AddUtilisateurState(
        file : file ?? this.file
    );
  }


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


class FormSubmissionError extends AddUtilisateurState  {
  final String error;

  FormSubmissionError(this.error);

  @override
  List<Object> get props => [error];
}

