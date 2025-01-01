import 'package:bboxxlog/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ParametresPage extends StatefulWidget {
  final String title;
  const ParametresPage({super.key, required this.title});

  @override
  State<ParametresPage> createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  String? userId;
  String? utilisateur;
  String? token;

  @override
  void initState(){
    super.initState();
    _getToken();
    _getEmail();
    _getEmail();
  }

   Future<void> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('access_token');
    });
  }
  Future<void> _getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      utilisateur = prefs.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            title: const Center(
              child:  Text(
              'Paramètres',
              style: TextStyle(color: Colors.white),
            ),),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  print("Déconnexion");
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.lock_reset,
                      color: Colors.blueAccent,
                      size: 26,
                    ),
                     SizedBox(width: 20),
                     Text(
                      'Change le mot de passe',
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  print("changer de langue");
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.wifi_protected_setup_rounded,
                      color: Colors.blueAccent,
                      size: 26,
                    ),
                     SizedBox(width: 20),
                     Text(
                      'Changer de langue',
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('access_token');
                  await prefs.remove('name');
                  Navigator.pop(context);
                  print("Déconnexions");
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.settings_power_sharp,
                      color: Colors.blueAccent,
                      size: 26,
                    ),
                     SizedBox(width: 20),
                     Text(
                      'Déconnexion',
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
            ],
          ),
        
      ),
    );
  }
}