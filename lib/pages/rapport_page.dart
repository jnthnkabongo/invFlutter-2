// import 'package:bboxxlog/models/inventaires.dart';
// import 'package:flutter/material.dart';

// void main(){
//   runApp(const MyTablePage(
//     home: listeInventaire();
//   ));
// }
// class MyTablePage extends StatefulWidget {
//   final String title;
//   const MyTablePage({super.key, required this.title});

//   @override
//   State<MyTablePage> createState() => _MyTablePageState();
// }

// class _MyTablePageState extends State<MyTablePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tableau Exemple'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: FutureBuilder<List<Inventaire>>(
//             future: listeInventaire(), 
//             builder: (context snapshot){
//               if(snapshot.connectionSate == ConnectionState.waiting){
//                 return Center(child : CircularProgressIndicator());
//               }else if (snapshot.hasError){
//                 return Center(child: Text('Erreur: ${snapshot.error}'));
//               }else {
//                 final invemtaire = snapshot.data;

//                 return ListView.builder(itemCount: inventaire?.lenght,
//                 itemBuilder: (context, index){
//                   return ListTile(
//                     title: Text(inventaire![index].title),
//                     subtitle: Text(inventaire[index].itemid),
//                   )
//                 })
//               }
//             }
//             )
//         ),
//       ),
      
//     );
//   }
// }

// import 'package:bboxxlog/models/inventaires.dart';
// import 'package:flutter/material.dart';
// import 'package:bboxxlog/services/auth_service.dart';

// void main() {
//   runApp(const MyTablePage(title: 'Liste des Inventaires'));
// }

// class MyTablePage extends StatefulWidget {
//   final String title;

//   const MyTablePage({super.key, required this.title});

//   @override
//   State<MyTablePage> createState() => _MyTablePageState();
// }

// class _MyTablePageState extends State<MyTablePage> {
//   final ApiService _apiService = ApiService();

//   late Future<List<Inventaire>> _listeInventaire;

//   @override
//   void initState(){
//     super.initState();
//     _listeInventaire = _apiService.listeInventaire();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: FutureBuilder<List<Inventaire>>(
//             future: _listeInventaire,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Erreur: ${snapshot.error}'));
//               } else if (snapshot.hasData){
//                 final inventaire = snapshot.data!;

//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics:const NeverScrollableScrollPhysics(),
//                   itemCount: inventaire.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(inventaire[index].title),
//                       subtitle: Text('ID : ${inventaire[index].itemid}'),
//                     );
//                   },
//                 );
//               } else {
//                 return const Center(child: Text('Aucune donée disponible'));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
//}

import 'package:bboxxlog/models/InventaireResponse.dart';
import 'package:bboxxlog/models/inventaires.dart';
import 'package:flutter/material.dart';
import 'package:bboxxlog/services/auth_service.dart';

void main() {
  runApp(const MaterialApp(
    home: MyTablePage(title: 'Liste des Inventaires'),
  ));
}

class MyTablePage extends StatefulWidget {
  final String title;

  const MyTablePage({super.key, required this.title});

  @override
  State<MyTablePage> createState() => _MyTablePageState();
}

class _MyTablePageState extends State<MyTablePage> {
  final ApiService _apiService = ApiService();

late Future<InventaireResponse> _inventaireResponse;

@override
void initState() {
  super.initState();
  _inventaireResponse = _apiService.listeInventaire();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<InventaireResponse>(
          future: _inventaireResponse,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur : ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final response = snapshot.data!;
              final inventaires = response.inventaires;
              final userName = response.userName;

              if (inventaires.isEmpty) {
                return const Center(child: Text('Aucune donnée disponible.'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nom de l\'utilisateur : ${userName.toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: inventaires.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            'Item: ${inventaires[index].itemid ?? 'Aucune donnée'}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            'Utilisateur: ${userName.isNotEmpty 
                                ? '${userName[0].toUpperCase()}${userName.substring(1)}' 
                                : 'Inconnu'}',
                            style: const TextStyle(color: Colors.black54),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            print('Item ${inventaires[index].itemid} tapped');
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Aucune donnée disponible.'));
            }
          },
        ),
      ),
    ),
  );
}
}
//   late Future<List<Inventaire>> _listeInventaire;
//   String? _userName;

//   @override
//    void initState() {
//   super.initState();
//   _listeInventaire = _apiService.listeInventaire().then((inventaires) {
//     if (inventaires.isNotEmpty) {
//       _userName = inventaires.first.username;
//       print('Nom de l\'utilisateur récupéré : $_userName');
//     } else {
//       print('Aucun inventaire trouvé.');
//     }
//     return inventaires;
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: FutureBuilder<List<Inventaire>>(
//             future: _listeInventaire,
//             builder: (context, snapshot) {
//               print('Snapshot state: ${snapshot.connectionState}');
//               print('Snapshot error: ${snapshot.error}');
//               print('Snapshot data: ${snapshot.data}');

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Erreur : ${snapshot.error}'));
//               } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                 final inventaire = snapshot.data!;
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: inventaire.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.all(15),
//                         leading: CircleAvatar(
//                           backgroundColor: Colors.blueAccent,
//                           child: Text(
//                             '${index + 1}',
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         title: Text(
//                           'Item: ${inventaire[index].itemid ?? 'Aucune donnée'}',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         subtitle: Text(
//                           'Utilisateur: ${_userName ?? 'Aucune donnée'}${inventaire[index].usernname}',
//                           style: const TextStyle(color: Colors.black54),
//                         ),
//                         trailing: const Icon(
//                           Icons.arrow_forward_ios,
//                           color: Colors.grey,
//                         ),
//                         onTap: () {
//                           // Action lors du clic sur un élément
//                           print('Item ${inventaire[index].itemid} tapped');
//                           print('Numero ${inventaire[index].username}');
//                         },
//                       ),
//                     );
//                   },
//                 );
//               } else {
//                 return const Center(child: Text('Aucune donnée disponible.'));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

