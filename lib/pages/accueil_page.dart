import 'package:bboxxlog/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  _AccueilPageState createState() => _AccueilPageState();
}


  class _AccueilPageState extends State<AccueilPage>{
    String? _token;

    Map<String, dynamic>? _userInfo;
    
    @override
    void initState(){
      super.initState();
      _loadToken();
    }
    Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('access_token'); // Récupérer le token
    });
    if (_token != null) {
      try {
        final userInfoResponse = await ApiService().getUserinfo(_token!);
        setState(() {
          _userInfo = userInfoResponse;
        });
      } catch (e) {
        print('Erreur lors de la recuperation des informations du user: ${e.toString()}');
      }
    }
    // Ici, vous pouvez également appeler votre API pour récupérer les informations de l'utilisateur
    // en utilisant le token pour authentifier la requête
  } 
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Information de l'utilisateur")),
      body: Center(
        child: _userInfo != null
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nom: ${_userInfo!['name'] ?? 'inconnu'}"),
            Text("Email: ${_userInfo!['email'] ?? 'inconnue'}"),
          ],
        )
        : const CircularProgressIndicator()
      ,),
    );
  }   
}
  // This widget is the root of your application.
 

