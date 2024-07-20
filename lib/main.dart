import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsidentification/view/add_todo/add_todo_bloc/add_todo_bloc.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_bloc.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/add_utilisateur_event.dart';
import 'package:sdealsidentification/view/add_utilisateur/screens/add_utilisateur_screen.dart';
import 'package:sdealsidentification/view/image_picker/screens/image_picker_screen.dart';
import 'package:sdealsidentification/view/list_todos/list_bloc/list_todo_bloc.dart';
import 'package:sdealsidentification/view/image_picker/image_picker_bloc/image_picker_bloc.dart';
import 'package:sdealsidentification/view/add_utilisateur/add_utilisateur_bloc/image_picker_utils.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddUtilisateurBloc>(
          create: (context) => AddUtilisateurBloc(ImagePickerUtils())..add(LoadGroupeSelectFieldData())   ,
        ),
      ],
      child: MaterialApp(
        title: 'Soutrali Deals',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey
                  )
              ),
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
              )
          ),

        ),
        home: const AddUtilisateurScreen(),
      ),
    );
  }
}