
import 'dart:ffi';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class Prestataire {
  String idutilisateur;
  String nomprenom;
  String telephone;
  String idservice;
  String nomservice;
  String prixmoyen;
  String localisation;
  String note;
  XFile?  cni1;
  XFile?  cni2;
  XFile? selfie;
  String verifier;

  Prestataire({
    required this.idutilisateur,
    required this.nomprenom,
    required this.telephone,
    required this.idservice,
    required this.nomservice,
    required this.prixmoyen,
    required this.localisation,
    required this.note,
    required this.cni1,
    required this.cni2,
    required this.selfie,
    required this.verifier,
  });

  Map<String, dynamic> toMap() {
    return {
      'idutilisateur': idutilisateur,
      'nomprenom': telephone,
      'idservice': idservice,
      'nomservice': nomservice,
      'prixmoyen': prixmoyen,
      'localisation': localisation,
      'note': note,
      'cni1': cni1,
      'cni2': cni2,
      'selfie': selfie,
      'verifier': verifier,
    };
  }
}


