import 'package:flutter/material.dart';
import 'package:bboxxlog/services/auth_service.dart';
import '../models/ItemResponse.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String itemId;
  final Item item;

  const DetailPage({
    super.key,
    required this.title,
    required this.itemId,
    required this.item,
  });

  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  final ApiService _apiService = ApiService();
  late Future<Item> _itemResponse;

  @override
  void initState() {
    super.initState();
    _itemResponse = _apiService.detailItems(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Détails de l\'Item',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Nom de l\'item', widget.item.name),
            _buildDetailRow('ID', widget.item.id.toString()),
            _buildDetailRow('Description', widget.item.description),
            _buildDetailRow('Shop/DC/RC', widget.item.localisations.name.toString()),
            _buildDetailRow('Numéro série', widget.item.numeroUnique),
            _buildDetailRow('Quantité', widget.item.quantiteId.toString()),
            // Ajoutez ici d'autres champs pertinents de l'item
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.title), // Utilisation du titre passé
  //     ),
  //     body: FutureBuilder<Item>(
  //       future: _itemResponse,
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text('Erreur: ${snapshot.error}'));
  //         } else if (snapshot.hasData) {
  //           final item = snapshot.data!;
  //           return Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text('Nom : ${item.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  //                 const SizedBox(height: 10),
  //                 Text('Description : ${item.description}'),
  //                 const SizedBox(height: 10),
  //                 Text('Numéro unique : ${item.numeroUnique}'),
  //                 const SizedBox(height: 10),
  //                 Text('Localisation : ${item.localisations.name}'),
  //                 const SizedBox(height: 10),
  //                 Text('Statut : ${item.status.status}'),
  //                 const SizedBox(height: 10),
  //                 Text('État : ${item.etatitems.state}'),
  //                 const SizedBox(height: 10),
  //                 Text('Type : ${item.typeitems.typeName}'),
  //               ],
  //             ),
  //           );
  //         }
  //         return const Center(child: Text('Aucune donnée disponible'));
  //       },
  //     ),
  //   );
  // }

// Bon
// import 'package:flutter/material.dart';

// class DetailPage extends StatelessWidget {
//   final Map<String, dynamic> item; // Les détails de l'item
//   final String title;

//   const DetailPage({super.key, required this.item, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Détails de l\'Item',
//               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueAccent,
//                   ),
//             ),
//             const SizedBox(height: 20),
//             _buildDetailRow('Nom de l\'item', item['name']?.toString() ?? 'Inconnu'),
//             _buildDetailRow('ID', item['itemid']?.toString() ?? 'Inconnu'),
//             _buildDetailRow('Description', item['description']?.toString() ?? 'Aucune description'),
//             _buildDetailRow('Shop/DC/RC', item['shopname_id']?.toString() ?? 'Inconnu'),
//             _buildDetailRow('Numéro série', item['numero_unique']?.toString() ?? 'Inconnu'),
//             _buildDetailRow('Quantité', item['quantite_id']?.toString() ?? 'Inconnu'),

//             // Ajoute ici d'autres champs pertinents de l'item
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               textAlign: TextAlign.right,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class DetailPage extends StatelessWidget {
//   final Map<String, dynamic> item; // Les détails de l'item
//   final String title;

//   const DetailPage({super.key, required this.item, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Détails de l\'Item',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const SizedBox(height: 20),
//             Text('Nom de l\'item: ${item['name'] ?? 'Inconnu'}'),
//             Text('ID: ${item['itemid'] ?? 'Inconnu'}'),
//             Text('Description: ${item['description'] ?? 'Aucune description'}'),
//             Text('Description: ${item['shopname_id'] ?? 'Aucune description'}'),
//             Text('Description: ${item['numero_unique'] ?? 'Aucune description'}'),
//             Text('Description: ${item['quantite_id'] ?? 'Aucune description'}'),


//             // Ajoute ici d'autres champs pertinents de l'item
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:bboxxlog/services/auth_service.dart';

// class DetailPage extends StatefulWidget {
//   final String itemid; // Le numéro unique de l'item
//   final String title;

//   const DetailPage({super.key, required this.itemid, required this.title, String? item});

//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   final ApiService _apiService = ApiService();
//   late Future<Map<String, dynamic>> _itemFuture;

//   @override
//   void initState() {
//     super.initState();
//     _itemFuture = _apiService.detailItems(widget.itemid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _itemFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Erreur : ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final data = snapshot.data!;
//             final userName = data['user_name'] ?? 'Non disponible';
//             final items = List<Map<String, dynamic>>.from(data['data'] ?? []);

//             return Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Affichage du nom de l'utilisateur
//                   Text(
//                     'Nom de l\'utilisateur : ${userName.toUpperCase()}',
//                     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//                   // Affichage de la liste des items
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: items.length,
//                       itemBuilder: (context, index) {
//                         final item = items[index];
//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 10),
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.all(15),
//                             title: Text(
//                               'Item ID : ${item['item_id']}',
//                               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Date d\'inventaire : ${item['date_inventaire']}',
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                                 Text(
//                                   'Créé le : ${item['created_at']}',
//                                   style: const TextStyle(fontSize: 14, color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text('Aucune donnée disponible.'));
//           }
//         },
//       ),
//     );
//   }
// }

// import 'package:bboxxlog/models/inventaires.dart';
// import 'package:flutter/material.dart';
// import 'package:bboxxlog/services/auth_service.dart';

// class DetailPage extends StatefulWidget {
//   final String itemid; // Le numéro de série de l'item
//   final String title;

//   const DetailPage({super.key, required this.itemid, required this.title, String? item});

//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   final ApiService _apiService = ApiService();
//   late Future<Map<String, dynamic>> _itemFuture;

//   @override
//   void initState() {
//     super.initState();
//     _itemFuture = _apiService.detailItems(widget.itemid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _itemFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Erreur : ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final itemid = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'ID de l\'Item : ${itemid['itemid'] ?? 'Non disponible'}',
//                     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Nom : ${itemid['name'] ?? 'Non disponible'}',
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Description : ${itemid['description'] ?? 'Non disponible'}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Numéro de série : ${itemid['numero_serie'] ?? 'Non disponible'}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text('Aucune donnée disponible.'));
//           }
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class DetailPage extends StatefulWidget {
//   final dynamic item; // Objet passé depuis la page principale
//   final String title;

//   const DetailPage({super.key, required this.item, required this.title});

//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//              appBar: PreferredSize(
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
//                     'Détail Item ',
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
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'ID de l\'item : ${widget.item.itemid}', // Afficher l'ID ici
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Autres informations : ${widget.item.toString()}', // Optionnel : afficher plus de détails si nécessaire
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DetailPage extends StatefulWidget {
//   final String item; // Le numéro de série de l'item
//   final String baseUrl;     // L'URL de base de l'API

//   const DetailPage({super.key, required this.item, required this.baseUrl, required String title});

//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   Map<String, dynamic>? itemDetails; // Pour stocker les données de l'API
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _fetchItemDetails();
//   }

//   Future<void> _fetchItemDetails() async {
//     final url = Uri.parse('${widget.baseUrl}/inventaire-materiel-${widget.item}');

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         setState(() {
//           itemDetails = jsonDecode(response.body);
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = 'Erreur : ${response.statusCode}';
//           isLoading = false;
//         });
//       }
//     } catch (error) {
//       setState(() {
//         errorMessage = 'Erreur de connexion : $error';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Détails de l\'Item ${widget.item}'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? Center(child: Text(errorMessage!))
//               : Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'ID : ${itemDetails!['id']}',
//                         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Nom : ${itemDetails!['name']}',
//                         style: const TextStyle(fontSize: 18),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Description : ${itemDetails!['description']}',
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//     );
//   }
// }

