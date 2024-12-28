// import 'package:bboxxlog/services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'QR Code Scanner',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const QRCode(title: 'QR Code Scanner'),
//     );
//   }
// }

// class QRCode extends StatefulWidget {
//   const QRCode({super.key, required String title});

//   @override
//   State<QRCode> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<QRCode> {
//   String scannedData = "Aucune donnée scannée";
//   String? userId;
//   String? utilisateur;
//   final TextEditingController _controller = TextEditingController();
//   final ApiService _apiService = ApiService();

//  @override
//   void initState(){
//     super.initState();
//     _getUserId();
//   }
//   Future<String?> _getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       utilisateur = prefs.getString('id');
//     });
//   }
  
//   Future<void> _soumettre(String itemId) async {
//     try {
//       String? utilisateur = await _getUserId();
//       if (utilisateur != null) {
//         await _apiService.savedValue(itemId, utilisateur);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Qr Code enregistré avec succes : $itemId')),);
//       }
//       else{
//         print('Identifiant non retrouvé dans SharedPreferences'); // Log pour débogage
//         ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Identifiant non retrouvé')),
//       );

//       }
//     } catch (e) {
//       print('Erreur : ${e.toString()}'); // Log pour débogage
//       ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Erreur : ${e.toString()}')),
//     );

//     }
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('QR Scanner')),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//               utilisateur != null ? "Bienvenu(e), $utilisateur" : "Bienvenu(e)",
//               style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
//             ),
//           SizedBox(
//             height: 300,
//             width: 300,
//             child: MobileScanner(
//               onDetect: (capture) {
//                 final List<Barcode> barcodes = capture.barcodes;
//                 for (final barcode in barcodes) {
//                   setState(() {
//                     scannedData = barcode.rawValue ?? "Aucune donnée trouvée dans le QR";
//                     _controller.text = scannedData; // Met à jour le champ de texte
//                   });
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _controller,
//               decoration: const InputDecoration(
//                 labelText: 'Donnée scannée',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               String itemId = _controller.text;
//               _soumettre(itemId);
//             },
//             child: const Text('Enregistrer'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:bboxxlog/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QRCode(title: 'QR Code Scanner'),
    );
  }
}

class QRCode extends StatefulWidget {
  const QRCode({super.key, required String title});

  @override
  State<QRCode> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<QRCode> {
  String scannedData = "Aucune donnée scannée";
  String? userId;
  String? utilisateur;
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _getEmail();
  }

  Future<void> _initializeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      utilisateur = prefs.getString('id');
    });
  }
  Future<void> _getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      utilisateur = prefs.getString('id');
    });
  }
  // Méthode pour soumettre les données
  Future<void> _soumettre(String itemId) async {
    if (itemId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le champ du QR Code est vide')),
      );
      return;
    }

    if (utilisateur == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Identifiant utilisateur non trouvé')),
      );
      return;
    }

    try {
      // Appel à l'API pour enregistrer les données
      await _apiService.savedValue(itemId, utilisateur!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR Code enregistré avec succès : $itemId')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'enregistrement : ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight), // Définir la taille de l'AppBar
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
          title: const Text(
            'Scanner QR Code',
            style: TextStyle(color: Colors.blueAccent),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    ),
      body: SingleChildScrollView(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              utilisateur != null ? "Bienvenu(e), $utilisateur" : "Bienvenu(e)",
              style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
            ),
          SizedBox(
            height: 300,
            width: 300,
            child: MobileScanner(
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  setState(() {
                    scannedData = barcode.rawValue ?? "Aucune donnée trouvée dans le QR";
                    _controller.text = scannedData; // Met à jour le champ de texte
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Donnée scannée',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String itemId = _controller.text;
              _soumettre(itemId);
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    ),);
  }
}
