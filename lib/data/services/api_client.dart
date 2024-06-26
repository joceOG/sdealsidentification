import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/groupe.dart';

class ApiClient {
  final String baseUrl='http://127.0.0.1:3000/api';

  Future<List<Groupe>> fetchGroupe() async {
    print('Base Url' + baseUrl );
    var request = http.MultipartRequest('GET', Uri.parse('$baseUrl/groupe'));
   final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      var get_groupe_response_string = await response.stream.bytesToString();
      List<dynamic> list_groupe_response_json = jsonDecode(get_groupe_response_string);
      List<Groupe> list_groupe = [];
      list_groupe_response_json .forEach((element) {
        Map<String, dynamic> map_groupe = (element);
        list_groupe.add(Groupe.fromJson(map_groupe));
      });
      return list_groupe ;
    } else {
      throw Exception('Failed to load items');
    }

  }
}