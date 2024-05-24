
import 'dart:ffi';
import 'dart:typed_data';

class Utilisateur {
  String nom;
  String prenom;
  String email;
  ByteBuffer photoprofil;
  String motdepasse;
  String telephone;
  String genre;
  String note;

  Utilisateur({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.photoprofil,
    required this.motdepasse,
    required this.telephone,
    required this.genre,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'photoprofil': photoprofil,
      'motdepasse': motdepasse,
      'telephone': email,
      'genre': genre,
      'note': note,
    };
  }
}


