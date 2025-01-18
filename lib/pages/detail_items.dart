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
                    'Détail item',
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