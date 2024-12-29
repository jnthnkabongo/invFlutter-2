// import 'package:bboxxlog/pages/home_page.dart';
// import 'package:bboxxlog/pages/qrcode_page.dart';
// import 'package:bboxxlog/pages/rapport_page.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main(){
//   runApp(MaterialApp(
//     theme: ThemeData(
//       colorSchemeSeed: Colors.blueAccent,
//       scaffoldBackgroundColor: Colors.white
//     ),
//   ));
// }
// class AccueilPage extends StatefulWidget {
//   const AccueilPage({super.key});

//   @override
//   _AccueilPageState createState() => _AccueilPageState();
// }

// class _AccueilPageState extends State<AccueilPage> {
//   String? token; 
//   String? utilisateur;

//   @override
//   void initState() {
//     super.initState();
//     _getToken();
//     _getEmail(); 
//   }

//   Future<void> _getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       token = prefs.getString('access_token'); 
//     });
//   }
//   Future<void> _getEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     utilisateur = prefs.getString('name');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: const [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 1.0),
            
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/images/image.png'),
//             const SizedBox(height: 20),
//             Text(
//               utilisateur != null ? "Bienvenue, $utilisateur " : "Bienvenue",
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 90),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.blue,
//                           width: 2
//                         ),
//                         borderRadius: BorderRadius.circular(12)
//                       ),
//                     ),
//                      IconButton(
//                       onPressed: (){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const QRCode(title: '',),
//                             ),
//                         );
//                       },
//                       icon: const Icon(Icons.qr_code),
//                       iconSize: 150,
//                       color: Colors.black,),
                    
//                       IconButton(
//                         onPressed: (){
//                         Navigator.push(
//                           context, 
//                         MaterialPageRoute(builder: (context) => const MyTablePage(title: '',),
//                         ),
//                         );
//                       },
//                         icon: const Icon(Icons.bar_chart_outlined),
//                         iconSize: 150,
//                         color: Colors.black,)
//                   ]
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 // Déconnexion
//                 final prefs = await SharedPreferences.getInstance();
//                 await prefs.remove('access_token'); 
//                 await prefs.remove('name'); 
//                 Navigator.pop(context); 
//               },
//               child: const Text("Déconnexion"),
//             ),
//           ],
//         ),
//       ),
//        bottomNavigationBar: NavigationBar(
//         backgroundColor: Colors.white,
//         destinations: const [
//           NavigationDestination(
//             icon: Icon(Icons.search), label: "Rechercher..."),
//           NavigationDestination(icon: Icon(Icons.home), label: "Accueil"),
//           NavigationDestination(icon: Icon(Icons.settings), label: "...")
//         ]),
//     );
//   }
// }
import 'package:bboxxlog/pages/parametres_page.dart';
import 'package:bboxxlog/pages/rapport_page.dart';
import 'package:bboxxlog/pages/return_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bboxxlog/pages/qrcode_page.dart';
void main() {
  runApp(MaterialApp(
    home: const AccueilPage(),
    theme: ThemeData(
      colorSchemeSeed: Colors.blueAccent,
      scaffoldBackgroundColor: Colors.white,
    ),
  ));
}

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  String? token;
  String? utilisateur;

  final pages = [
    const AccueilPage(),
    const ParametresPage(title: '',)
  ];

  int pageIndex = 0;
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
    setState(() {
      utilisateur = prefs.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 2,
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
        ),
      body: //pages[pageIndex],
       Center(
         child: Column(
          children: [
            Image.asset('assets/images/image.png'),
            const SizedBox(height: 20),
            Text(
              utilisateur != null
                ? "Bienvenu(e), ${utilisateur?.toUpperCase()}"
                : "Bienvenu(e)",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton QR Code
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QRCode(title: 'Page QR Code'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.qr_code),
                    iconSize: 120,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 20),
                // Bouton MyTablePage
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyTablePage(title: 'Page Tableau'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.bar_chart_outlined),
                    iconSize: 120,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
           
          ],
        ),
      ),

      floatingActionButton: const FloatingActionButton(onPressed: null,
      backgroundColor: Colors.blueAccent,
      child: Icon(Icons.add_box_outlined)),
      floatingActionButtonLocation:FloatingActionButtonLocation.endFloat,
    );
  }
}