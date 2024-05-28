//import 'dart:html';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdealsidentification/data/models/todo.dart';
import 'package:sdealsidentification/data/models/utilisateur.dart';
import 'package:sdealsidentification/data/services/database_service.dart';

import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_event.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_state.dart';
import 'package:sdealsidentification/data/controllers/add_utilisateur_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';

class AddUtilisateurBloc extends Bloc<AddUtilisateurEvent, AddUtilisateurState> {
  //final DatabaseService databaseService = DatabaseService.instance;

  AddUtilisateurBloc() : super(AddUtilisateurInitialState()) {
    on<AddUtilisateurEvent>((event, emit) async {

      if(event is AddUtilisateurInitialEvent) {
        emit(AddUtilisateurInitialState());
      }

      if(event is AddUtilisateurButtonPressed) {
        print("User Click")  ;
        Utilisateur utilisateur = event.utilisateur;

        var request = http.MultipartRequest('POST', Uri.parse('http://localhost:3000/api/utilisateur'));
        request.fields.addAll({
          'nom': utilisateur.nom,
          'prenom': utilisateur.prenom,
          'email': utilisateur.email,
          'motdepasse': utilisateur.motdepasse,
          'telephone': utilisateur.telephone,
          'genre': utilisateur.genre,
          'note': utilisateur.note,
        });
        request.files.add(await http.MultipartFile.fromPath('photoprofil' ,
            utilisateur.photoprofil!.path ));

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
          emit(AddUtilisateurSuccessState());
        }
        else {
          print(response.reasonPhrase);
          emit(const AddUtilisateurErrorState(message: 'Une erreur est surveneue'));

        }



      }
      if(event is AddUtilisateurButtonPressed) {
            print("User Click")  ;
          Utilisateur utilisateur = event.utilisateur;

          var request = http.MultipartRequest('POST', Uri.parse('http://localhost:3000/api/utilisateur'));
          request.fields.addAll({
            'nom': utilisateur.nom,
            'prenom': utilisateur.prenom,
            'email': utilisateur.email,
            'motdepasse': utilisateur.motdepasse,
            'telephone': utilisateur.telephone,
            'genre': utilisateur.genre,
            'note': utilisateur.note,
          });
          request.files.add(await http.MultipartFile.fromPath('photoprofil' ,
               utilisateur.photoprofil!.path ));

          http.StreamedResponse response = await request.send();

          if (response.statusCode == 200) {
            print(await response.stream.bytesToString());
            emit(AddUtilisateurSuccessState());
          }
          else {
            print(response.reasonPhrase);
            emit(const AddUtilisateurErrorState(message: 'Une erreur est surveneue'));

          }



      }


    });
  }

  @override
  Stream<AddUtilisateurState> mapEventToState(AddUtilisateurEvent event) async* {
    print('PickImage') ;
    if (event is PickImage) {
      try {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          yield ImagePicked(File(pickedFile.path));
        }
      } catch (e) {
        yield FormSubmissionError('Failed to pick image');
      }
    }
  }

}