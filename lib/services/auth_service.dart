import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<dynamic> login(String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
    headers: {
      'Context-Type' : 'application/json; charset=UTF-8',
      'Accept' : 'application/json'
    },
    body: {
      'email': email,
      'password' : password,
    },
    );
    print(response.statusCode);
    print('email: $email');
    print('password: $password');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Erreur de connexion: ${response.statusCode} - ${response.body} - ${response.headers}');
    }
  }

  Future<Map<String, dynamic>> getUserinfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token == null) {
      throw Exception('Token non trouver');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Authorization' :'Baerer $token',
      },
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);

      print('Informations utilisateur : $userData');
      return userData;
    }else{
      print('Erreur lors de la récupération des informations de l\'utilisateur: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');
      throw Exception('Echec de la recuperation des informations');
    }
  }

  //inventory
  Future<dynamic> savedValue(String itemId) async {
    final response = await http.post(Uri.parse('$baseUrl/inventaire'),
    headers: {
      'Context-Type' : 'application/json; charset=UTF-8',
      'Accept' : 'application/json'
    },
    body: {
      'item_id': itemId,
    },
    );
    if (response.statusCode != 201) {
      throw Exception('Erreur lors de l\'enregistrement: ${response.body}');
    }
  }

}
