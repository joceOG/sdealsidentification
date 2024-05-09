import 'package:equatable/equatable.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_bloc.dart';

abstract class AddUtilisateurState extends Equatable {
  const AddUtilisateurState();

  @override
  List<Object> get props => [];
}

final class AddUtilisateurInitialState extends AddUtilisateurState {}

class LoadingAddUtilisateurState extends AddUtilisateurState {}

class AddUtilisateurSuccessState extends AddUtilisateurState {}

class AddUtilisateurErrorState extends AddUtilisateurState {
  final String message;
  const AddUtilisateurErrorState({required this.message});

  @override
  List<Object> get props => [message];
}