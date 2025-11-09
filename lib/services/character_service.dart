import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/character.dart';

class CharacterService {
  final _ref = FirebaseFirestore.instance.collection('personagens');

  // Adiciona personagem
  Future<String> addCharacter(Character character) async {
    final docRef = await _ref.add(character.toMap());
    return docRef.id;
  }

  // Atualiza personagem existente
  Future<void> updateCharacter(Character character) async {
    if (character.id == null) throw Exception('ID do personagem não encontrado');
    await _ref.doc(character.id).update(character.toMap());
  }

  // Remove personagem
  Future<void> deleteCharacter(String id) async {
    await _ref.doc(id).delete();
  }

  // Busca 1 personagem por id
  Future<Character?> fetchCharacter(String id) async {
    final doc = await _ref.doc(id).get();
    if (!doc.exists) return null;
    return Character.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
  }

  // Stream/lista de personagens do usuário
  Stream<List<Character>> streamCharacters(String userId) {
    return _ref.where('user_id', isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Character.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }
}
