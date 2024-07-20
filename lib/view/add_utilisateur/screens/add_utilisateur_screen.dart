import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdealsidentification/data/controllers/add_prestataire_controller.dart';
import 'package:sdealsidentification/data/controllers/add_utilisateur_controller.dart';
import 'package:sdealsidentification/data/models/prestataire.dart';
import 'package:sdealsidentification/data/models/todo.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_bloc.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_event.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_state.dart';
import 'package:sdealsidentification/view/list_todos/list_bloc/list_todo_event.dart';
import 'dart:io';
import '../../../data/models/groupe.dart';
import '../../../data/models/utilisateur.dart';
import '../../../widgets/custom_loader.dart';

class AddUtilisateurScreen extends StatefulWidget {
  const AddUtilisateurScreen({super.key});

  @override
  State<AddUtilisateurScreen> createState() => _AddUtilisateurScreenState();
}

class _AddUtilisateurScreenState extends State<AddUtilisateurScreen> {
  final AddUtilisateurController addUtilisateurController = AddUtilisateurController();
  final AddPrestataireController addPrestataireontroller = AddPrestataireController();
  final formKey = GlobalKey<FormState>();
  String? _selectedValue;
  String? _selectedValue2;
  String? _selectedValue3;
  late XFile? photoprofil;
  late XFile? cni1;
  late XFile? cni2;
  late XFile? selfie;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 155.0, // add this line
        centerTitle: false, //width and height
        // The size the AppBar would prefer if there were no other constraints.
        title: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 70, bottom: 30),
            child: Container(
              height: 153,
              child: const Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Soutrali',
                        style: TextStyle(
                            color: Color(0xff28A545),
                            fontWeight: FontWeight.bold,
                            fontSize: 40)),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Deals',
                        style: TextStyle(
                            color: Color(0xff28A545),
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
         child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<AddUtilisateurBloc, AddUtilisateurState>(
                  builder: (context, state) {

                    if (state is AddUtilisateurErrorState) {
                      return messageText(message: state.message, type: 'error');
                    } else if (state is AddUtilisateurSuccessState) {
                      return messageText(
                          message: 'Utilisateur ajouté', type: 'success');
                    }

                    return Container();
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.nom,
                    hintText: 'Nom'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.prenom,
                    hintText: 'Prenom'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.email,
                    hintText: 'Email'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.motdepasse,
                    hintText: 'Mot de Passe'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.telephone,
                    hintText: 'Numero de Téléphone'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.genre,
                    hintText: 'Genre'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.note,
                    hintText: 'Note'),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Photo de Profil :'),
                    ),
                    Expanded(
                      child: BlocBuilder<AddUtilisateurBloc, AddUtilisateurState>(
                        builder: (context, state){
                          return state.file1 == null ? InkWell(
                            onTap: (){
                              context.read<AddUtilisateurBloc>().add(GalleryPicker(numeroPicture:1));
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.camera),
                            ),
                          ) : Image.file(File(state.file1!.path.toString()),height: 200,width: 200,);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Prestataire'),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<AddUtilisateurBloc, AddUtilisateurState>(
                  builder: (context, state) {
                    return
                    state.dropdownItems == null ?
                      Center(child: CircularProgressIndicator()) :
                      DropdownButtonFormField<String>(
                        value: _selectedValue,
                        items: state.dropdownItems
                            ?.map((item) => DropdownMenuItem<String>(
                          value:  "${item.idgroupe}_${item.nomgroupe}",
                          child: Text(item.nomgroupe),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                          String? nomgroupe = _selectedValue?.split("_")[1];
                          BlocProvider.of<AddUtilisateurBloc>(context)
                              .add(LoadCategorieSelectFieldData(nomgroupe: nomgroupe!));
                        },
                        decoration: InputDecoration(labelText: 'Select Field'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an item';
                          }
                          return null;
                        },
                      ) ;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
             BlocBuilder<AddUtilisateurBloc, AddUtilisateurState>(
                builder: (context, state) {
                    return
                      state.dropdownItems2 == null ?
                      Center(child: CircularProgressIndicator()) :
                      DropdownButtonFormField<String>(
                        value: _selectedValue2,
                        items: state.dropdownItems2
                            ?.map((item) => DropdownMenuItem<String>(
                          value: "${item.idcategorie}_${item.nomcategorie}",
                          child: Text(item.nomcategorie),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue2 = value;
                          });
                          String? nomcategorie = _selectedValue2?.split("_")[1];
                          BlocProvider.of<AddUtilisateurBloc>(context)
                              .add(LoadServiceSelectFieldData(nomcategorie: nomcategorie!));
                        },
                        decoration: InputDecoration(labelText: 'Select Field'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an item';
                          }
                          return null;
                        },
                      ) ;
                },
              ),

                const SizedBox(
                  height: 12,
                ),
                BlocBuilder<AddUtilisateurBloc, AddUtilisateurState>(
                  builder: (context, state) {
                    return
                      state.dropdownItems3 == null ?
                      Center(child: CircularProgressIndicator()) :
                      DropdownButtonFormField<String>(
                        value: _selectedValue3,
                        items: state.dropdownItems3
                            ?.map((item) => DropdownMenuItem<String>(
                          value: "${item.idservice}_${item.nomservice}",
                          child: Text(item.nomservice),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue3 = value;
                          });
                        },
                        decoration: InputDecoration(labelText: 'Select Field'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an item';
                          }
                          return null;
                        },
                      ) ;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addPrestataireontroller.prixmoyen,
                    hintText: 'Prix Moyen'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addPrestataireontroller.localisation,
                    hintText: 'Localisation'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addPrestataireontroller.note,
                    hintText: 'Note'),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('CNI RECTO:'),
                    ),
                    Expanded(
                      child: BlocBuilder<AddUtilisateurBloc, AddUtilisateurState>(
                        builder: (context, state){
                          return state.file2 == null ? InkWell(
                            onTap: (){
                              context.read<AddUtilisateurBloc>().add(GalleryPicker(numeroPicture:2));
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.camera),
                            ),
                          ) : Image.file(File(state.file2!.path.toString()),height: 200,width: 200 );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('CNI :'),
                    ),
                    Expanded(
                      child: BlocBuilder<AddUtilisateurBloc, AddUtilisateurState>(
                        builder: (context, state){
                          return state.file3 == null ? InkWell(
                            onTap: (){
                              context.read<AddUtilisateurBloc>().add(GalleryPicker(numeroPicture:3));
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.camera),
                            ),
                          ) : Image.file(File(state.file3!.path.toString()),height: 200,width: 200 );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Selfie'),
                    ),
                    Expanded(
                      child: BlocBuilder<AddUtilisateurBloc, AddUtilisateurState>(
                        builder: (context, state){
                          return state.file4 == null ? InkWell(
                            onTap: (){
                              context.read<AddUtilisateurBloc>().add(GalleryPicker( numeroPicture: 4));
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.camera),
                            ),
                          ) : Image.file(File(state.file4!.path.toString()),height: 200,width: 200,);
                        },
                      ),
                    ),
                  ],
                ),
                formField(
                    controller: addPrestataireontroller.verifier,
                    hintText: 'Vérifier'),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  height: 12,
                ),
                BlocBuilder<AddUtilisateurBloc, AddUtilisateurState>(
                  builder: (context, state){
                    return ElevatedButton(
                        onPressed: () {
                          print("Click");
                          Utilisateur utilisateur = Utilisateur(
                              nom: addUtilisateurController.nom.value.text,
                              prenom: addUtilisateurController.prenom.value.text,
                              email: addUtilisateurController.email.value.text,
                              motdepasse: addUtilisateurController.nom.value.text,
                              telephone: addUtilisateurController.telephone.value.text,
                              genre: addUtilisateurController.genre.value.text,
                              note: addUtilisateurController.note.value.text,
                              photoprofil: state.file1,
                          );
                          print("Nom " + utilisateur.nom);
                          print("Path Photo " + utilisateur.photoprofil!.path.toString());

                          //Prestataire
                          Prestataire prestataire = Prestataire(
                            idutilisateur: "",
                            nomprenom: addUtilisateurController.nom.value.text +
                                addUtilisateurController.prenom.value.text,
                            telephone: addUtilisateurController.telephone.value.text,
                            idservice: _selectedValue3!.split("_")[0],
                            nomservice: _selectedValue3!.split("_")[1],
                            prixmoyen: addPrestataireontroller.prixmoyen.value.text,
                            note: addPrestataireontroller.note.value.text,
                            localisation: addPrestataireontroller.localisation.value.text,
                            cni1: state.file2,
                            cni2: state.file3,
                            selfie: state.file4,
                            verifier: addPrestataireontroller.verifier.value.text,
                          );

                          BlocProvider.of<AddUtilisateurBloc>(context)
                              .add(AddUtilisateurButtonPressed
                            (utilisateur: utilisateur , prestataire: prestataire));

                       /*   if (isFormValid()) {
                            print('Form Valid');
                            Utilisateur utilisateur = Utilisateur(
                                nom: addUtilisateurController.nom.value.text,
                                prenom: addUtilisateurController.prenom.value.text,
                                email: addUtilisateurController.email.value.text,
                                motdepasse: addUtilisateurController.nom.value.text,
                                telephone: addUtilisateurController.telephone.value.text,
                                genre: addUtilisateurController.genre.value.text,
                                note: addUtilisateurController.note.value.text,
                                photoprofil: photo
                            );
                            print(utilisateur);
                            print("End User");

                            BlocProvider.of<AddUtilisateurBloc>(context)
                                .add(AddUtilisateurButtonPressed(utilisateur: utilisateur));
                          } */
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            fixedSize: Size(MediaQuery.of(context).size.width, 30)),
                        child: const Text(
                          'Ajouter',
                          style: TextStyle(color: Colors.white),
                        )) ;
                  },
                ),

              ],
            ),
          ),
        ),
      ), ),
    );
  }

  TextFormField formField({
    required TextEditingController controller,
    required String hintText,
    bool isRequired = true,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        validator: (value) {
          if (isRequired) {
            if (value == null || value.isEmpty) {
              return 'Ce champ est obligatoire.';
            }
          }
          return null;
        },
        decoration: InputDecoration(hintText: hintText),
      );

  bool isFormValid() =>
          addUtilisateurController.nom.text.isNotEmpty &&
          addUtilisateurController.prenom.text.isNotEmpty &&
          addUtilisateurController.email.text.isNotEmpty &&
          addUtilisateurController.motdepasse.text.isNotEmpty &&
          addUtilisateurController.telephone.text.isNotEmpty &&
          addUtilisateurController.genre.text.isNotEmpty &&
          addUtilisateurController.note.text.isNotEmpty &&
          addUtilisateurController.photoprofil != null



  ;

  Center messageText({
    required String message,
    required String type,
  }) =>
      Center(
        child: Text(
          message,
          style: TextStyle(
            color:
                type == 'success' ? Colors.green.shade700 : Colors.red.shade700,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
          ),
        ),
      );
}