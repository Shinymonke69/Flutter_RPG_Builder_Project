class Character {
  String? id; 
  String userId; 
  String name;
  String? surname;
  String race;
  String charClass; 
  Map<String, dynamic> attributes; 
  String? powers;
  String? history;
  String? inventory;
  DateTime? createdAt;
  DateTime? updatedAt;

  Character({
    this.id,
    required this.userId,
    required this.name,
    this.surname,
    required this.race,
    required this.charClass,
    required this.attributes,
    this.powers,
    this.history,
    this.inventory,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'surname': surname,
      'race': race,
      'class': charClass,
      'attributes': attributes,
      'powers': powers,
      'history': history,
      'inventory': inventory,
      'created_at': (createdAt ?? DateTime.now()).toIso8601String(),
      'updated_at': (updatedAt ?? DateTime.now()).toIso8601String(),
    };
  }

  factory Character.fromFirestore(Map<String, dynamic> doc, String id) {
    return Character(
      id: id,
      userId: doc['user_id'],
      name: doc['name'],
      surname: doc['surname'],
      race: doc['race'],
      charClass: doc['class'],
      attributes: Map<String, dynamic>.from(doc['attributes']),
      powers: doc['powers'],
      history: doc['history'],
      inventory: doc['inventory'],
      createdAt: doc['created_at'] != null
          ? DateTime.parse(doc['created_at'])
          : null,
      updatedAt: doc['updated_at'] != null
          ? DateTime.parse(doc['updated_at'])
          : null,
    );
  }
}
