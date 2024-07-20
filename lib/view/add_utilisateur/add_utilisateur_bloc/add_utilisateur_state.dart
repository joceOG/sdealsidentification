import 'dart:ffi';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_bloc.dart';

import '../../../data/models/categorie.dart';
import '../../../data/models/groupe.dart';
import '../../../data/models/service.dart';

class AddUtilisateurState extends Equatable {
  final XFile? file1 ;
  final XFile? file2 ;
  final XFile? file3 ;
  final XFile? file4 ;
  final bool? isLoading;
  final List<Groupe>? dropdownItems;
  final String? selectedValue;
  final String? error;
  final bool? isLoading2;
  final List<Categorie>? dropdownItems2;
  final String? selectedValue2;
  final String? error2;
  final bool? isLoading3;
  final List<Service>? dropdownItems3;
  final String? selectedValue3;
  final String? error3;

  const AddUtilisateurState( {
    this.file1,
    this.file2,
    this.file3,
    this.file4,
    this.isLoading,
    this.dropdownItems,
    this.selectedValue,
    this.error,
    this.isLoading2,
    this.dropdownItems2,
    this.selectedValue2,
    this.error2,
    this.isLoading3,
    this.dropdownItems3,
    this.selectedValue3,
    this.error3,
});

  factory AddUtilisateurState.initial() {
    return const AddUtilisateurState(
      isLoading: true,
      dropdownItems: [],
      selectedValue: '',
      error: '',
      file1: null,
      file2: null,
      file3: null,
      file4: null,
      isLoading2 : true,
      dropdownItems2 : [],
      selectedValue2 : '',
      error2 : '',
      isLoading3 : true,
      dropdownItems3 : [],
      selectedValue3 : '',
      error3 : '',
    );
  }

  AddUtilisateurState copyWith({
    XFile? file1 ,
    XFile? file2 ,
    XFile? file3 ,
    XFile? file4 ,
    bool? isLoading,
    List<Groupe>? dropdownItems,
    String? selectedValue,
    String? error,
    bool? isLoading2,
    List<Categorie>? dropdownItems2,
    String? selectedValue2,
    String? error2,
    bool? isLoading3,
    List<Service>? dropdownItems3,
    String? selectedValue3,
    String? error3,
  }){
    return AddUtilisateurState(
      file1 : file1 ?? this.file1,
      file2 : file2 ?? this.file2,
      file3 : file3 ?? this.file3,
      file4 : file4 ?? this.file4,
      isLoading: isLoading ?? this.isLoading,
      dropdownItems: dropdownItems ?? this.dropdownItems,
      selectedValue: selectedValue ?? this.selectedValue,
      error: error ?? this.error,
      isLoading2: isLoading2 ?? this.isLoading2,
      dropdownItems2: dropdownItems2 ?? this.dropdownItems2,
      selectedValue2: selectedValue2 ?? this.selectedValue2,
      error2: error2 ?? this.error2,
      isLoading3: isLoading3 ?? this.isLoading3,
      dropdownItems3: dropdownItems3 ?? this.dropdownItems3,
      selectedValue3: selectedValue3 ?? this.selectedValue3,
      error3: error3 ?? this.error3,
    );
  }


  @override
  List<Object?> get props => [ file1, file2, file3, file4,
    isLoading, dropdownItems, selectedValue, error,
    isLoading2, dropdownItems2, selectedValue2, error2,
    isLoading3, dropdownItems3, selectedValue3, error3];
}


class AddUtilisateurSuccessState extends AddUtilisateurState {
  AddUtilisateurSuccessState({
    super.isLoading,
    super.dropdownItems,
    super.selectedValue,
    super.error, required String message});

  @override
  List<Object?> get props => [isLoading, dropdownItems, selectedValue, error];
}

class AddUtilisateurErrorState extends AddUtilisateurState {
  final String message;
  const AddUtilisateurErrorState({
    required this.message,
    super.isLoading,
    super.dropdownItems,
    super.selectedValue,
    super.error});

  @override
  List<Object?> get props => [message, isLoading, dropdownItems, selectedValue, error];

}


class FormSubmissionError extends AddUtilisateurState  {

  const FormSubmissionError({
    required super.isLoading,
    required super.dropdownItems,
    required super.selectedValue,
    required super.error});

  @override
  List<Object?> get props => [isLoading, dropdownItems, selectedValue, error];

}

