import 'package:bboxxlog/models/inventaires.dart';

class InventaireResponse {
  final String userName;
  final List<Inventaire> inventaires;

  InventaireResponse({required this.userName, required this.inventaires});
}