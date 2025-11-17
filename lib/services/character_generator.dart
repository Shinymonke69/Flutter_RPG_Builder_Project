import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:faker/faker.dart';

const List<String> historyExamples = [
  'Acólito: Cresceu servindo em um templo, aprendendo rituais sagrados e ajudando fiéis.',
  'Soldado: Lutou em batalhas pelo reino, conhece táticas de guerra e tem contatos militares.',
  'Forasteiro: Viveu isolado na natureza, entendendo trilhas, sobrevivência e caçadas.',
  'Charlatão: Mestre dos disfarces e truques, consegue manipular quase qualquer um.',
  'Nobre: Tem influência política, foi educado em etiqueta e possui bens herdados.',
  'Artesão de Guilda: Pertence à guilda famosa, sabe negociar e possui colegas influentes.',
  'Náufrago: Sobreviveu a desastres, desenvolveu habilidades de sobrevivência em ilhas remotas.',
];

const List<String> inventoryExamples = [
  'Espada curta, capa resistente, kit de aventureiro',
  'Machado de batalha, escudo de madeira, mochila de viagem',
  'Arco longo, aljava com flechas, mapa antigo',
  'Livro de magia, amuleto sagrado, túnica bordada',
  'Bolsa de moedas, carta misteriosa, lanterna',
];

// atributos
Map<String, int> generateAttributes() {
  final rand = Random();
  return {
    'strength': rand.nextInt(11) + 8,
    'dexterity': rand.nextInt(11) + 8,
    'constitution': rand.nextInt(11) + 8,
    'intelligence': rand.nextInt(11) + 8,
    'wisdom': rand.nextInt(11) + 8,
    'charisma': rand.nextInt(11) + 8,
  };
}


final faker = Faker();
String firstName = faker.person.firstName();
String lastName = faker.person.lastName();

String getRandom(List<String> list) => list[Random().nextInt(list.length)];

// classe
Future<String> getRandomClass() async {
  final resp = await http.get(Uri.parse('https://www.dnd5eapi.co/api/classes/'));
  if (resp.statusCode == 200) {
    final json = jsonDecode(resp.body);
    final results = json['results'] as List;
    if (results.isEmpty) return 'Fighter';
    final item = results[Random().nextInt(results.length)];
    return item['name'];
  }
  return 'Fighter';
}

// raça
Future<String> getRandomRace() async {
  final resp = await http.get(Uri.parse('https://www.dnd5eapi.co/api/races/'));
  if (resp.statusCode == 200) {
    final json = jsonDecode(resp.body);
    final results = json['results'] as List;
    if (results.isEmpty) return 'Human';
    final item = results[Random().nextInt(results.length)];
    return item['name'];
  }
  return 'Human';
}

// magias
Future<String> getRandomSpells([int count = 3]) async {
  final resp = await http.get(Uri.parse('https://www.dnd5eapi.co/api/spells/'));
  if (resp.statusCode == 200) {
    final json = jsonDecode(resp.body);
    final results = json['results'] as List;
    if (results.isEmpty) return '';
    
    final rand = Random();
    final indices = List.generate(count, (_) => rand.nextInt(results.length));
    final names = indices.map((i) => results[i]['name']).toSet().toList();
    return names.join(', ');
  }
  return '';
}

Future<Map<String, dynamic>> generateRandomCharacter(String userId) async {
  final faker = Faker();
  final name = faker.person.firstName();
  final surname = faker.person.lastName();
  final history = getRandom(historyExamples);
  final inventory = getRandom(inventoryExamples);
  final attributes = generateAttributes();
  final charClass = await getRandomClass();
  final race = await getRandomRace();
  final powers = await getRandomSpells(3);

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
    'created_at': DateTime.now().toIso8601String(),
    'updated_at': DateTime.now().toIso8601String(),
  };
}
