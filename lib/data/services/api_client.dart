import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl='http://127.0.0.1:3000/api';

  Future<List<dynamic>> fetchGroupe() async {
    print('Base Url' + baseUrl );
    var request = http.MultipartRequest('GET', Uri.parse('$baseUrl/groupe'));
   final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      var get_groupe_response_string = await response.stream.bytesToString();
      return json.decode(get_groupe_response_string);
    } else {
      throw Exception('Failed to load items');
    }

  }
}