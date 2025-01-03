class Item {
  final int id;
  final String name;
  final String description;
  final String numeroUnique;
  final Localisation localisations;
  final int quantiteId; // Ajoutez ce modèle
  final Status status; // Ajoutez ce modèle
  final EtatItem etatitems; // Ajoutez ce modèle
  final TypeItem typeitems; // Ajoutez ce modèle

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.numeroUnique,
    required this.localisations,
    required this.quantiteId,
    required this.status,
    required this.etatitems,
    required this.typeitems,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      numeroUnique: json['numero_unique'],
      quantiteId: json['quantite_id'],
      localisations: Localisation.fromJson(json['localisations']),
      status: Status.fromJson(json['status']),
      etatitems: EtatItem.fromJson(json['etatitems']),
      typeitems: TypeItem.fromJson(json['typeitems']),
    );
  }

  get shopnameId => null;

  get quantiteIds => null;
}

class Localisation {
  final int id;
  final String name;

  Localisation({required this.id, required this.name});

  factory Localisation.fromJson(Map<String, dynamic> json) {
    return Localisation(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Status {
  final int id;
  final String status;

  Status({required this.id, required this.status});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      status: json['status'],
    );
  }
}

class EtatItem {
  final int id;
  final String state;

  EtatItem({required this.id, required this.state});

  factory EtatItem.fromJson(Map<String, dynamic> json) {
    return EtatItem(
      id: json['id'],
      state: json['state'],
    );
  }
}

class TypeItem {
  final int id;
  final String typeName;

  TypeItem({required this.id, required this.typeName});

  factory TypeItem.fromJson(Map<String, dynamic> json) {
    return TypeItem(
      id: json['id'],
      typeName: json['type_name'],
    );
  }
}