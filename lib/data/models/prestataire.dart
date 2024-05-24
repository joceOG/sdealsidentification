
import 'dart:ffi';
import 'dart:typed_data';

class Prestataire {
  String idutilisateur;
  String idservice;
  String nomservice;
  String prixmoyen;
  String localisation;
  String note;
  ByteBuffer  cni;
  ByteBuffer  selfie;
  Bool verifier;

  Prestataire({
    required this.idutilisateur,
    required this.idservice,
    required this.nomservice,
    required this.prixmoyen,
    required this.localisation,
    required this.note,
    required this.cni,
    required this.selfie,
    required this.verifier,
  });

  Map<String, dynamic> toMap() {
    return {
      'idutilisateur': idutilisateur,
      'idservice': idservice,
      'nomservice': nomservice,
      'prixmoyen': prixmoyen,
      'localisation': localisation,
      'note': note,
      'cni': cni,
      'selfie': selfie,
      'verifier': verifier,
    };
  }
}


