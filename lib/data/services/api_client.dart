import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sdealsidentification/data/models/categorie.dart';

import '../models/groupe.dart';
import '../models/service.dart';

class ApiClient {
  final String baseUrl='http://127.0.0.1:3000/api';

  Future<List<Groupe>> fetchGroupe() async {
    print('Base Url' + baseUrl );

    var request = http.MultipartRequest('GET', Uri.parse('$baseUrl/groupe'));
   final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     // print(await response.stream.bytesToString());
      var get_groupe_response_string = await response.stream.bytesToString();
      print('uno') ;
      print(get_groupe_response_string);
      var add1 = '{"groupe" : ' ;
      var add2 = '}';
      var get_groupe_response_string_json = add1 + get_groupe_response_string + add2 ;
      print(get_groupe_response_string_json );
      List<Groupe> list_groupe = [];
      var tagObjsJson = jsonDecode(get_groupe_response_string_json)['groupe'] as List;
    //   print(tagObjsJson);
       list_groupe = tagObjsJson.map((tagJson) => Groupe.fromJson(tagJson)).toList();
     print('Liste Groupe' + list_groupe.toString() ) ;
      return list_groupe;
    } else {
      throw Exception('Failed to load items');
    }

  }


  Future<List<Categorie>> fetchCategorie(String nomgroupe) async {
    print('Base Url' + baseUrl );
    var request = http.MultipartRequest('GET', Uri.parse('$baseUrl/categorie'));
    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var get_categorie_response_string = await response.stream.bytesToString();
      print('uno') ;
      print(get_categorie_response_string);
      var add1 = '{"categorie" : ' ;
      var add2 = '}';
      var get_categorie_response_string_json = add1 + get_categorie_response_string + add2 ;
      print(get_categorie_response_string_json );
      List<Categorie> list_categorie = [];
      var tagObjsJson = jsonDecode(get_categorie_response_string_json)['categorie'] as List;
      //   print(tagObjsJson);
      list_categorie = tagObjsJson.map((tagJson) => Categorie.fromJson(tagJson)).toList();
      print('Liste Categorie' + list_categorie.toString() ) ;

      return list_categorie;
    } else {
      throw Exception('Failed to load items');
    }

  }

  Future<List<Service>> fetchService(String nomcategorie) async {
    print('Base Url' + baseUrl );
    var request = http.MultipartRequest('GET', Uri.parse('$baseUrl/service/$nomcategorie'));
    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var get_service_response_string = await response.stream.bytesToString();
      print('uno') ;
      //print(get_service_response_string);
      var add1 = '{"service" : ' ;
      var add2 = '}';
      var get_service_response_string_json = add1 + get_service_response_string + add2 ;
      //print(get_service_response_string_json );
      List<Service> list_service = [];
      var tagObjsJson = jsonDecode(get_service_response_string_json)['service'] as List;
      //   print(tagObjsJson);
      list_service = tagObjsJson.map((tagJson) => Service.fromJson(tagJson)).toList();
      print('Liste Service') ;

      return list_service;
    } else {
      throw Exception('Failed to load items');
    }

  }

}


