import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  String? token; 
  String? utilisateur;

  @override
  void initState() {
    super.initState();
    _getToken();
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
    utilisateur = prefs.getString('name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //       child: Center(
      //         child: Text(
      //           utilisateur != null ? "Bienvenue, $utilisateur" : "Bienvenue",
      //           style: const TextStyle(fontSize: 16),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/image.png'),
            const SizedBox(height: 20),
            Text(
              utilisateur != null ? "Bienvenue, $utilisateur " : "Bienvenue",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 90),
                     IconButton(
                      onPressed: null,
                      icon: Icon(Icons.qr_code),
                      iconSize: 180,
                      color: Colors.black,),
                    
                      IconButton(onPressed: null,
                        icon: Icon(Icons.bar_chart_outlined),
                        iconSize: 180,
                        color: Colors.black,)
                  ]
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Déconnexion
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('access_token'); 
                await prefs.remove('name'); 
                Navigator.pop(context); 
              },
              child: const Text("Déconnexion"),
            ),
          ],
        ),
      ),
    );
  }
}