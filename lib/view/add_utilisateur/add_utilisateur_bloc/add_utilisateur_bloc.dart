//import 'dart:html';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdealsidentification/data/models/todo.dart';
import 'package:sdealsidentification/data/models/utilisateur.dart';
import 'package:sdealsidentification/data/services/api_client.dart';
import 'package:sdealsidentification/data/services/database_service.dart';
import 'package:sdealsidentification/view/add_todo/add_todo_bloc/add_todo_event.dart';

import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_event.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_state.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/image_picker_utils.dart';
import 'package:sdealsidentification/data/controllers/add_utilisateur_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';

import '../../../data/models/groupe.dart';

class AddUtilisateurBloc extends Bloc<AddUtilisateurEvent, AddUtilisateurState> {
  //final DatabaseService databaseService = DatabaseService.instance;
  final ImagePickerUtils imagePickerUtils ;


  AddUtilisateurBloc(this.imagePickerUtils) : super(AddUtilisateurInitialState()) {
    on<CameraCapture>(_cameraCapture);
    on<GalleryPicker>(_galleryPicker);
    on<FetchListGroupeEvent>(_fetchGroupe);

    on<AddUtilisateurEvent>((event, emit) async {



      if(event is AddUtilisateurInitialEvent) {
        emit(AddUtilisateurInitialState());
      }

      if(event is AddUtilisateurButtonPressed) {
        print("User Click")  ;
        Utilisateur utilisateur = event.utilisateur;

        var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:3000/api/utilisateur'));
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
          print("User Add Success") ;
        }
        else {
          print(response.reasonPhrase);
          emit(const AddUtilisateurErrorState(message: 'Une erreur est surveneue'));
          print("User Add Error") ;
        }
      }

      if(event is FetchListGroupeEvent) {

      }

    });
  }

  void _fetchGroupe(FetchListGroupeEvent event , Emitter<AddUtilisateurState> emit)async{
    ApiClient apiClient = ApiClient() ;
    emit(LoadingListGroupeState());
    try {
      print('Requete : Liste Groupe') ;
      List<Groupe> list_groupe = await apiClient.fetchGroupe();
      emit(ListGroupeSuccesState(groupe: list_groupe));
    } catch (e) {
      emit( ListGroupeErrorState(message: 'Une erreur est survenue' + e.toString()));
    }
  }


  void _cameraCapture(CameraCapture event , Emitter<AddUtilisateurState> emit)async{
    XFile? file = await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file: file));
  }
  void _galleryPicker(GalleryPicker event , Emitter<AddUtilisateurState> emit)async{
    XFile? file = await imagePickerUtils.pickImageFromGallery();
    emit(state.copyWith(file: file));
  }

}