import 'package:bboxxlog/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();

  void _soumettre(String itemId) async {
    try {
      await _apiService.savedValue(itemId);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Valeur enregistré : $itemId')),);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: ${e.toString()}')),);
    }
  }

  @override
  void initState(){
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
    );
  }
}