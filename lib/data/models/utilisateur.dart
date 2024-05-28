
import 'dart:io';

class Utilisateur {
  String nom;
  String prenom;
  String email;
  String motdepasse;
  String telephone;
  String genre;
  String note;
  File? photoprofil;

  Utilisateur({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motdepasse,
    required this.telephone,
    required this.genre,
    required this.note,
    required this.photoprofil,
  });

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'motdepasse': motdepasse,
      'telephone': email,
      'genre': genre,
      'note': note,
      'photoprofil': photoprofil,
    };
  }
}


