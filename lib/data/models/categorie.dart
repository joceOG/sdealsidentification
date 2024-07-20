
import 'dart:ffi';
import 'dart:typed_data';

class Categorie{
  String idcategorie;
  String nomcategorie;
  String idgroupe;
  String nomgroupe;


  Categorie({
    required this.idcategorie,
    required this.nomcategorie,
    required this.idgroupe,
    required this.nomgroupe,
  });

  /*factory Groupe.fromJson(Map<String, dynamic> json){
    return Groupe(
      idgroupe: json['idgroupe'] as String,
      nomgroupe:  json['nomgroupe'] as String,
    );
  } */

  factory Categorie.fromJson(dynamic json) {
    return Categorie(
        idcategorie : json['_id'] as String,
        nomcategorie: json['nomcategorie'] as String,
        idgroupe : json['idgroupe'] as String,
        nomgroupe: json['nomgroupe'] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      'idcategorie': idcategorie,
      'nomcategorie': nomcategorie,
      'idgroupe': idgroupe,
      'nomgroupe': nomgroupe
      ,
    };
  }
}


