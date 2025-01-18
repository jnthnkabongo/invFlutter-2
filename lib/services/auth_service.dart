import 'dart:convert';
import 'package:bboxxlog/models/InventaireResponse.dart';
import 'package:bboxxlog/models/ItemResponse.dart';
import 'package:bboxxlog/models/inventaires.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://192.168.1.85:8000/api'; //http://127.0.0.1:8000/api/liste-materiels; http://192.168.69.40:8000 / Bureau 192.168.1.85 Routeur Vodacom 192.168.123.35

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
    Future<InventaireResponse> listeInventaire() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('Token non trouvé. Veuillez vous reconnecter.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/liste-materiel'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final userName = jsonResponse['user_name'] as String? ?? 'Utilisateur inconnu';
      final inventaires = (jsonResponse['data'] as List)
          .map((inventaire) => Inventaire.fromJson(inventaire))
          .toList();

      return InventaireResponse(userName: userName, inventaires: inventaires);
    } else if (response.statusCode == 401) {
      throw Exception('Utilisateur non authentifié. Veuillez vérifier votre connexion.');
    } else {
      throw Exception('Problème de connexion : ${response.body}');
    }
  }

  //inventory
  Future<dynamic> savedValue(String itemId, String utilisateur) async {
    final response = await http.post(Uri.parse('$baseUrl/inventaire'),
    headers: {
      'Context-Type' : 'application/json; charset=UTF-8',
      'Accept' : 'application/json'
    },
    body: {
      'item_id': itemId,
      'user_id': utilisateur
    },
    );
    if (response.statusCode != 201) {
      throw Exception('Erreur lors de l\'enregistrement: ${response.body}');
    }
  }

  Future<void> saveUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', userId);
  print('Identifiant: $userId'); // Enregistre l'ID
  }
  
  Future<Item> detailItems(String itemid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('Token non trouvé. Veuillez vous reconnecter.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/inventairemateriel/$itemid'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Réponse API : ${response.body}');
      return Item.fromJson(json.decode(response.body)); // Conversion ici
    } else {
      print('Erreur API : ${response.statusCode} - ${response.body}');
      throw Exception(
        'Erreur lors de la récupération de l\'item : ${response.statusCode}',
      );
    }
  }
  Future<InventaireResponse> fetchInventaireItems(String query) async {
  final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('Token non trouvé. Veuillez vous reconnecter.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/rechercher-item?query=$query'),
      headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(response.body);
      final userName = jsonResponse['user_name'] as String? ?? 'Utilisateur inconnu';
      final inventaires = (jsonResponse['data'] as List)
        .map((inventaire)=> Inventaire.fromJson(inventaire))
        .toList();
      return InventaireResponse(userName: userName, inventaires: inventaires);
    } else if (response.statusCode == 401) {
      print('Erreur : ${response.statusCode} - ${response.body}');
      throw Exception('Aucune donnée trouvée');
    }else {
      throw Exception('Problème de connexion : ${response.body}');
    }
  }
}