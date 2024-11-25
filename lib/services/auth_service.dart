import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8000/api';

  Future<dynamic> login(String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
    headers: {
      'Context-Type' : 'application/json; charset=UTF-8'
    },
    body: 
    {
      'email': email,
      'password' : password
    },
    );
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }else{
      throw Exception('Erreur de connexion: ${response.statusCode} - ${response.body} - ${response.headers}');
    }
  }
  // Future<String?> loadToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('acces_token');
  // }

  Future<Map<String, dynamic>> getUserinfo(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Authorization' :'Baerer $token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }else{
      print('Erreur lors de la récupération des informations de l\'utilisateur: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');
      throw Exception('Echec de la recuperation des informations');
    }
  }
}
