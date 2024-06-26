import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdealsidentification/data/controllers/add_utilisateur_controller.dart';
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
  late AddUtilisateurController addUtilisateurController;
  late AddUtilisateurController addPrestataireontroller;
  late GlobalKey<FormState> formKey;
  late XFile? photo;

  @override
  void initState() {
    BlocProvider.of<AddUtilisateurBloc>(context)
        .add(FetchListGroupeEvent());





    addUtilisateurController = AddUtilisateurController();
    formKey = GlobalKey();
    super.initState();
  }

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
                    hintText: 'Email'),
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
                          return state.file == null ? InkWell(
                            onTap: (){
                              context.read<AddUtilisateurBloc>().add(GalleryPicker());
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.camera),
                            ),
                          ) : Image.file(File(state.file!.path.toString()),height: 200,width: 200,);
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
                    if(state is ListGroupeSuccesState) {
                      final List<Groupe> groupe = state.groupe;
                      return groupe.isEmpty ?
                      const Center(child: Text('Pas de Groupe'),) :
                      SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: groupe.asMap().entries.map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.value.nomgroupe,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                                if(e.key != groupe.length - 1) const Divider(
                                  color: Colors.grey,
                                )
                              ],
                            )).toList()
                        ),
                      );
                    } else if (state is ListGroupeErrorState) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return const CustomLoader();
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.nom,
                    hintText: 'Categorie'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.nom,
                    hintText: 'Service'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.prenom,
                    hintText: 'Prix Moyen'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.email,
                    hintText: 'Localisation'),
                const SizedBox(
                  height: 12,
                ),
                formField(
                    controller: addUtilisateurController.motdepasse,
                    hintText: 'Note'),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('CNI:'),
                    ),
                    Expanded(
                      child: BlocBuilder<AddUtilisateurBloc, AddUtilisateurState>(
                        builder: (context, state){
                          return state.file == null ? InkWell(
                            onTap: (){
                              context.read<AddUtilisateurBloc>().add(GalleryPicker());
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.camera),
                            ),
                          ) : Image.file(File(state.file!.path.toString()),height: 200,width: 200,);
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
                          return state.file == null ? InkWell(
                            onTap: (){
                              context.read<AddUtilisateurBloc>().add(GalleryPicker());
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.camera),
                            ),
                          ) : Image.file(File(state.file!.path.toString()),height: 200,width: 200,);
                        },
                      ),
                    ),
                  ],
                ),
                formField(
                    controller: addUtilisateurController.note,
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
                              photoprofil: state.file,
                          );
                          print("Nom " + utilisateur.nom);
                          print("Prenom " + utilisateur.prenom);
                          print("Path Photo " + utilisateur.photoprofil!.path.toString().toString());

                          BlocProvider.of<AddUtilisateurBloc>(context)
                              .add(AddUtilisateurButtonPressed(utilisateur: utilisateur));

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