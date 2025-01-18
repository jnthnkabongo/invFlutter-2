import 'package:flutter/material.dart';
import 'package:bboxxlog/services/auth_service.dart';
import 'package:bboxxlog/pages/detail_items.dart';
import 'package:bboxxlog/models/inventaires.dart';
import '../models/InventaireResponse.dart';

class MyTablePage extends StatefulWidget {
  final String title;

  const MyTablePage({super.key, required this.title});

  @override
  State<MyTablePage> createState() => _MyTablePageState();
}

class _MyTablePageState extends State<MyTablePage> {
  final ApiService _apiService = ApiService();
  List<Inventaire> _rechercherItems = [];
  String _query = '';
  late Future<InventaireResponse> _inventaireResponse;
  
  var userName;

  @override
  void initState() {
    super.initState();
    _inventaireResponse = _apiService.listeInventaire();
  }

  void _rechercheItems() async {
  if (_query.isNotEmpty) {
    try {
      final inventaireResponse = await _apiService.fetchInventaireItems(_query);
      setState(() {
        _inventaireResponse = Future.value(inventaireResponse);
      });
    } catch (error) {
      print('Erreur lors de la recherche : $error');
    }
  }
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
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Liste inventaire',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 60)
              ],
            ),
          ),
        ),
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
                _rechercherItems = response.inventaires;
                final userName = response.userName;

                if (_rechercherItems.isEmpty) {
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
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Rechercher...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _query = value; // Met à jour la requête de recherche
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _rechercheItems, // Appelle la fonction de recherche
                      child: const Text('Rechercher'),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _rechercherItems.length,
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
                            title: Text('Item: ${_rechercherItems[index].itemid ?? 'Aucune donnée'}'),
                            subtitle: Text('Utilisateur: ${userName.isNotEmpty? '${userName[0].toLowerCase()}${userName.substring(1)}' : 'Inconnu'}',
                            style: const TextStyle(color: Colors.black),), // Ajoutez le nom de l'utilisateur si nécessaire
                            onTap: () async {
                              final itemId = _rechercherItems[index].itemid;

                              try {
                                final itemDetails = await _apiService.detailItems(itemId!);
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      item: itemDetails,
                                      title: 'Détails de l\'item',
                                      itemId: itemId,
                                    ),
                                  ),
                                );
                              } catch (error) {
                                print('Erreur lors de la récupération des détails : $error');
                              }
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
// import 'package:flutter/material.dart';
// import 'package:bboxxlog/services/auth_service.dart';
// import 'package:bboxxlog/pages/detail_items.dart';
// import 'package:bboxxlog/models/inventaires.dart';
// import '../models/InventaireResponse.dart';

// class MyTablePage extends StatefulWidget {
//   final String title;

//   const MyTablePage({super.key, required this.title});

//   @override
//   State<MyTablePage> createState() => _MyTablePageState();
// }

// class _MyTablePageState extends State<MyTablePage> {
//   final ApiService _apiService = ApiService();
//   List<Inventaire> _rechercherItems = [];
//   String _query = '';
//   late Future<InventaireResponse> _inventaireResponse;

//   @override
//   void initState() {
//     super.initState();
//     _inventaireResponse = _apiService.listeInventaire();
//   }

//   void _rechercheItems(String query) {
//   setState(() {
//     _query = query;
//     _inventaireResponse = _apiService.fetchInventaireItems(query).then((inventaires) {
//       return InventaireResponse(inventaires: inventaires, userName: 'Nom de l\'utilisateur'); // Ajoutez un nom d'utilisateur si nécessaire
//     });
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.blueAccent,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 0,
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: AppBar(
//             automaticallyImplyLeading: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             title: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Liste inventaire',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 60)
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child : Padding(
//         padding: const EdgeInsets.all(20),
//         child: FutureBuilder<InventaireResponse>(
//           future: _inventaireResponse,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Erreur : ${snapshot.error}'));
//             } else if (snapshot.hasData) {
//               final response = snapshot.data!;
//               _rechercherItems = response.inventaires;
//               final userName = response.userName;

//               if (_rechercherItems.isEmpty) {
//                 return const Center(child: Text('Aucune donnée disponible.'));
//               }

//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                        'Nom de l\'utilisateur : ${userName.toUpperCase()}',
//                        style: const TextStyle(
//                          fontSize: 18,
//                          fontWeight: FontWeight.bold,
//                        ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.search),
//                       hintText: 'Rechercher...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                     onChanged: _rechercheItems,
//                   ),
//                   const SizedBox(height: 20),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: _rechercherItems.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)
//                         ),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(15),
//                              leading: CircleAvatar(
//                                backgroundColor: Colors.blueAccent,
//                                child: Text(
//                                  '${index + 1}',
//                                  style: const TextStyle(color: Colors.white),
//                                ),
//                           ),
//                           title: Text('Item: ${_rechercherItems[index].itemid ?? 'Aucune donnée'}'),
//                           subtitle: const Text('Utilisateur: Inconnu'), // Ajoutez le nom de l'utilisateur si nécessaire
//                           onTap: () async {
//                             final itemId = _rechercherItems[index].itemid;

//                             try {
//                               final itemDetails = await _apiService.detailItems(itemId!);
//                               Navigator.push(context,
//                                 MaterialPageRoute(
//                                   builder: (context) => DetailPage(
//                                     item: itemDetails,
//                                     title: 'Détails de l\'item',
//                                     itemId: itemId,
//                                   ),
//                                 ),
//                               );
//                             } catch (error) {
//                               print('Erreur lors de la récupération des détails : $error');
//                             }
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               );
//             } else {
//               return const Center(child: Text('Aucune donnée disponible.'));
//             }
//           },
//         ),
//       ),
//       )
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:bboxxlog/services/auth_service.dart';
// import 'package:bboxxlog/pages/detail_items.dart';
// import 'package:bboxxlog/models/inventaires.dart';
// import '../models/InventaireResponse.dart';

// class MyTablePage extends StatefulWidget {
//   final String title;

//   const MyTablePage({super.key, required this.title});

//   @override
//   State<MyTablePage> createState() => _MyTablePageState();
// }

// class _MyTablePageState extends State<MyTablePage> {
//   final ApiService _apiService = ApiService();
//   List<Inventaire> _inventaires = [];
//   List<Inventaire> _rechercherItems = [];
//   String _query = '';
//   late Future<InventaireResponse> _inventaireResponse;

//   @override
//   void initState() {
//     super.initState();
//     _inventaireResponse = _apiService.listeInventaire();
//   }

//   void _rechercheItems(String query) {
//     setState(() {
//       _query = query;
//       _rechercherItems = _inventaires.where((inventaire) {
//         return inventaire.itemid?.toLowerCase().contains(query.toLowerCase()) ?? false;
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.blueAccent,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 0,
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: AppBar(
//             automaticallyImplyLeading: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             title: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Liste inventaire',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 60)
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: FutureBuilder<InventaireResponse>(
//             future: _inventaireResponse,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Erreur : ${snapshot.error}'));
//               } else if (snapshot.hasData) {
//                 final response = snapshot.data!;
//                 _inventaires = response.inventaires;
//                 final userName = response.userName;

//                 if (_inventaires.isEmpty) {
//                   return const Center(child: Text('Aucune donnée disponible.'));
//                 }

//                 // Initialiser _rechercherItems avec tous les éléments
//                 _rechercherItems = List.from(_inventaires);

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Nom de l\'utilisateur : ${userName.toUpperCase()}',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.search),
//                         hintText: 'Rechercher...',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                       ),
//                       onChanged: _rechercheItems,
//                     ),
//                     const SizedBox(height: 20),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: _rechercherItems.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.all(15),
//                             leading: CircleAvatar(
//                               backgroundColor: Colors.blueAccent,
//                               child: Text(
//                                 '${index + 1}',
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                             ),
//                             title: Text(
//                               'Item: ${_rechercherItems[index].itemid ?? 'Aucune donnée'}',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             subtitle: Text(
//                               'Utilisateur: ${userName.isNotEmpty 
//                                   ? '${userName[0].toUpperCase()}${userName.substring(1)}' 
//                                   : 'Inconnu'}',
//                               style: const TextStyle(color: Colors.black54),
//                             ),
//                             trailing: const Icon(
//                               Icons.arrow_forward_ios,
//                               color: Colors.grey,
//                             ),
//                             onTap: () async {
//                               final itemId = _rechercherItems[index].itemid;

//                               try {
//                                 final itemDetails = await _apiService.detailItems(itemId!);
//                                 Navigator.push(context,
//                                   MaterialPageRoute(
//                                     builder: (context) => DetailPage(
//                                       item: itemDetails,
//                                       title: 'Détails de l\'item',
//                                       itemId: itemId,
//                                     ),
//                                   ),
//                                 );
//                               } catch (error) {
//                                 print('Erreur lors de la récupération des détails : $error');
//                               }
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ],
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
// import 'package:flutter/material.dart';
// import 'package:bboxxlog/services/auth_service.dart';
// import 'package:bboxxlog/pages/detail_items.dart';
// import 'package:bboxxlog/models/inventaires.dart';

// import '../models/InventaireResponse.dart';

// class MyTablePage extends StatefulWidget {
//   final String title;

//   const MyTablePage({super.key, required this.title});

//   @override
//   State<MyTablePage> createState() => _MyTablePageState();
// }

// class _MyTablePageState extends State<MyTablePage> {
//   final ApiService _apiService = ApiService();
//   List <Inventaire> _inventaires = [];
//   List <Inventaire> _rechercherItems = [];
//   String _query = '';
//   late Future<InventaireResponse> _inventaireResponse;

//   @override
//   void initState() {
//     super.initState();
//     _inventaireResponse = _apiService.listeInventaire();
//   }
//   void _rechercheItems(String query){
//     final rechercherItem = _inventaires.where((inventaires){
//       return inventaires.itemid?.toLowerCase().contains(query.toLowerCase()) ?? false;
//     }).toList();

//     setState(() {
//       _rechercherItems = rechercherItem;
//       _query = query;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.blueAccent,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 0,
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: AppBar(
//             automaticallyImplyLeading: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             title: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Liste inventaire',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 60)
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: FutureBuilder<InventaireResponse>(
//             future: _inventaireResponse,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Erreur : ${snapshot.error}'));
//               } else if (snapshot.hasData) {
//                 final response = snapshot.data!;
//                 _inventaires = response.inventaires;
//                 final userName = response.userName;

//                 if (_inventaires.isEmpty) {
//                   return const Center(child: Text('Aucune donnée disponible.'));
//                 }
//                 _rechercherItems = List.from(_inventaires);

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Nom de l\'utilisateur : ${userName.toUpperCase()}',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     SearchBar(
//                       leading: const Icon(Icons.search),
//                       hintText: 'Rechercher...',
//                       backgroundColor: const WidgetStatePropertyAll(Colors.white),
//                       elevation: const WidgetStatePropertyAll(4.0),
//                       shape: WidgetStatePropertyAll(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                       ),
//                       onChanged: _rechercheItems,
//                     ),
//                     const SizedBox(height: 20),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: _rechercherItems.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.all(15),
//                             leading: CircleAvatar(
//                               backgroundColor: Colors.blueAccent,
//                               child: Text(
//                                 '${index + 1}',
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                             ),
//                             title: Text(
//                               'Item: ${_rechercherItems[index].itemid ?? 'Aucune donnée'}',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             subtitle: Text(
//                               'Utilisateur: ${userName.isNotEmpty 
//                                   ? '${userName[0].toUpperCase()}${userName.substring(1)}' 
//                                   : 'Inconnu'}',
//                               style: const TextStyle(color: Colors.black54),
//                             ),
//                             trailing: const Icon(
//                               Icons.arrow_forward_ios,
//                               color: Colors.grey,
//                             ),
//                             onTap: () async {
//                               final itemId = _rechercherItems[index].itemid;

//                               try {
//                                 final itemDetails = await _apiService.detailItems(itemId!);
//                                 Navigator.push(context,
//                                   MaterialPageRoute(
//                                     builder: (context) => DetailPage(
//                                       item: itemDetails,
//                                       title: 'Détails de l\'item',
//                                       itemId:itemId,
//                                     ),
//                                   ),
//                                 );
//                               } catch (error) {
//                                 print('Erreur lors de la récupération des détails : $error');
//                               }
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ],
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
