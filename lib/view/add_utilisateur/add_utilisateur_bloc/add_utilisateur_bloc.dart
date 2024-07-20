//import 'dart:html';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdealsidentification/data/models/prestataire.dart';
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

import '../../../data/models/categorie.dart';
import '../../../data/models/groupe.dart';
import '../../../data/models/service.dart';

class AddUtilisateurBloc extends Bloc<AddUtilisateurEvent, AddUtilisateurState> {
  //final DatabaseService databaseService = DatabaseService.instance;
  final ImagePickerUtils imagePickerUtils ;


  AddUtilisateurBloc(this.imagePickerUtils) : super( AddUtilisateurState.initial()) {
    on<CameraCapture>(_cameraCapture);
    on<GalleryPicker>(_galleryPicker);
    on<LoadGroupeSelectFieldData>(_onLoadGroupeSelectFieldData);
    on<LoadCategorieSelectFieldData>(_onLoadCategorieSelectFieldData);
    on<LoadServiceSelectFieldData>(_onLoadServiceSelectFieldData);
    on<AddUtilisateurButtonPressed>(_onAddUtilisateurButtonPressed);
  }

  Future<void> _onLoadGroupeSelectFieldData(
      LoadGroupeSelectFieldData event,
      Emitter<AddUtilisateurState> emit,
      ) async {

    emit(state.copyWith(isLoading: true));

    ApiClient apiClient = ApiClient() ;
    print("Try") ;
    try {
     //  List<Groupe> list_groupe = await apiClient.fetchGroupe();
      List<Groupe> list_groupe = await apiClient.fetchGroupe();
      print("List Groupe") ;
      emit(state.copyWith(dropdownItems: list_groupe, isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> _onLoadCategorieSelectFieldData(
      LoadCategorieSelectFieldData event,
      Emitter<AddUtilisateurState> emit,
      ) async {

    String nomgroupe = event.nomgroupe;
   // emit(state.copyWith3(isLoading2: true));
    emit(state.copyWith(isLoading2: true));

    ApiClient apiClient = ApiClient() ;
    print("Try") ;
    try {
      List<Categorie> list_categorie = await apiClient.fetchCategorie(nomgroupe);
      print("List Categorie") ;
      emit(state.copyWith(dropdownItems2: list_categorie, isLoading2: false));

    } catch (error) {
   //   emit(state.copyWith3(error2: error.toString(), isLoading2: false));
      emit(state.copyWith(error2: error.toString(), isLoading2: false));
    }
  }


  Future<void> _onLoadServiceSelectFieldData(
      LoadServiceSelectFieldData event,
      Emitter<AddUtilisateurState> emit,
      ) async {
    String nomcategorie = event.nomcategorie;
    // emit(state.copyWith3(isLoading2: true));
    emit(state.copyWith(isLoading3: true));
    ApiClient apiClient = ApiClient() ;
    print("Try") ;
    try {
      List<Service> list_service = await apiClient.fetchService(nomcategorie);
      print("List Service") ;
      emit(state.copyWith(dropdownItems3: list_service, isLoading3: false));
    } catch (error) {
      //   emit(state.copyWith3(error2: error.toString(), isLoading2: false));
      emit(state.copyWith(error3: error.toString(), isLoading3: false));
    }
  }


  void _onAddUtilisateurButtonPressed( AddUtilisateurButtonPressed event, Emitter<AddUtilisateurState> emit) async {
    print("User Click")  ;
    Utilisateur utilisateur = event.utilisateur;
    Prestataire prestataire = event.prestataire ;

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
      //print(await response.stream.bytesToString());
      print("Next");
      var utilisateur_response_json = jsonDecode(await response.stream.bytesToString());
      print ( utilisateur_response_json["_id"]) ;
      prestataire.idutilisateur = utilisateur_response_json["_id"] ;
      addPrestatire(prestataire);
      print("User Add Success") ;

      emit(AddUtilisateurSuccessState(message: 'Utilisateur ajouté avec succès'));
    }
    else {
      print(response.reasonPhrase);
      emit(AddUtilisateurErrorState(message: 'Une erreur est survenue'));
      print("User Add Error") ;
    }

  }


  void _cameraCapture(CameraCapture event , Emitter<AddUtilisateurState> emit)async{
    XFile? file1 = await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file1: file1));
  }
  void _galleryPicker(GalleryPicker event , Emitter<AddUtilisateurState> emit)async{
    XFile? file = await imagePickerUtils.pickImageFromGallery();

    if ( event.numeroPicture == 1  ) {
      emit(state.copyWith(file1: file));
    }
    else if ( event.numeroPicture == 2  ) {
      emit(state.copyWith(file2: file));
    }
    else if ( event.numeroPicture == 3  ) {
      emit(state.copyWith(file3: file));
    }
    else if ( event.numeroPicture == 4  ) {
      emit(state.copyWith(file4: file));
    }


  }

  Future<void> addPrestatire ( Prestataire prestataire) async {

    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:3000/api/prestataire'));
    request.fields.addAll({
      'idutilisateur': prestataire.idutilisateur,
      'idservice': prestataire.idservice,
      'nomprenom': prestataire.nomprenom,
      'nomservice': prestataire.nomservice,
      'prixmoyen': prestataire.prixmoyen,
      'localisation': prestataire.localisation,
      'note': prestataire.note,
      'verifier': prestataire.verifier,
    });
    request.files.add(await http.MultipartFile.fromPath('cni1' ,
        prestataire.cni1!.path ));

    request.files.add(await http.MultipartFile.fromPath('cni2' ,
    prestataire.cni2!.path ));

    request.files.add(await http.MultipartFile.fromPath('selfie' ,
    prestataire.selfie!.path ));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    //print(await response.stream.bytesToString());

    print("Prestataire Add Success") ;
    }
    else {
    print(response.reasonPhrase);
    print("Prestataire Add Error") ;
    }

  }
}