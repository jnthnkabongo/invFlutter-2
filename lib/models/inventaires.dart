class Inventaire {
  final int? id;
  final int? userid;
  final String? itemid;
  final DateTime? createdAt;

  Inventaire({required this.id,required this.userid, required this.itemid,required this.createdAt});

  factory Inventaire.fromJson(Map<String, dynamic> json) {
    return Inventaire(
      id: json['id'], 
      userid: json['user_id'],
      itemid: json['item_id'],
      createdAt: DateTime.parse(json['date_inventaire']),
    );
  }

}