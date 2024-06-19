
import 'dart:ffi';
import 'dart:typed_data';

class Groupe {
  String idgroupe;
  String nomgroupe;

  Groupe({
    required this.idgroupe,
    required this.nomgroupe,
  });


  factory Groupe.fromJson(Map<String, dynamic> json){
    return Groupe(
      idgroupe: json['idgroupe'] as String,
      nomgroupe:  json['nomgroupe'] as String,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'idgroupe': idgroupe,
      'nomgroupe': nomgroupe
      ,
    };
  }
}


