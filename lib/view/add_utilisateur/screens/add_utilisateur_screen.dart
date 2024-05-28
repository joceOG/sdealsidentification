import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsidentification/data/controllers/add_utilisateur_controller.dart';
import 'package:sdealsidentification/data/models/todo.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_bloc.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_event.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_state.dart';
import 'dart:io';
import '../../../data/models/utilisateur.dart';

class AddUtilisateurScreen extends StatefulWidget {
  const AddUtilisateurScreen({super.key});

  @override
  State<AddUtilisateurScreen> createState() => _AddUtilisateurScreenState();
}

class _AddUtilisateurScreenState extends State<AddUtilisateurScreen> {
  late AddUtilisateurController addUtilisateurController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    BlocProvider.of<AddUtilisateurBloc>(context)
        .add(AddUtilisateurInitialEvent());
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
        height: MediaQuery.of(context).size.height / 0.8,
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
                    else if (state is ImagePicked) {
                      print("image pick click");
                      setState(() {
                        addUtilisateurController.photoprofil = state.photoprofil;
                      });
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
                addUtilisateurController.photoprofil == null
                    ? Text('No image selected.')
                    : Image.file(addUtilisateurController.photoprofil!),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                     print('checking');

                    BlocProvider.of<AddUtilisateurBloc>(context)
                        .add(PickImage());
                  },
                  child: Text('Pick Image'),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () {
                      print("Click");
                      if (isFormValid()) {
                        Utilisateur utilisateur = Utilisateur(
                            nom: addUtilisateurController.nom.value.text,
                            prenom: addUtilisateurController.prenom.value.text,
                            email: addUtilisateurController.email.value.text,
                            motdepasse: addUtilisateurController.nom.value.text,
                            telephone: addUtilisateurController.telephone.value.text,
                            genre: addUtilisateurController.genre.value.text,
                            note: addUtilisateurController.note.value.text,
                            photoprofil: addUtilisateurController.photoprofil
                        );
                        print(utilisateur);
                        print("End User");
                        BlocProvider.of<AddUtilisateurBloc>(context)
                            .add(AddUtilisateurButtonPressed(utilisateur: utilisateur));
                      }
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
                    )),
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