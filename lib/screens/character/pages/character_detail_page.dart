import 'package:flutter/material.dart';
import '../../../models/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;
  const CharacterDetailPage({required this.character, super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${character.name} ${character.surname ?? ""}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6F4E37), // Cor marrom igual às outras páginas
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            width: 370, 
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 22),
            decoration: BoxDecoration(
              color: const Color(0xFF6F4E37), 
              borderRadius: BorderRadius.circular(22), 
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Raça: ${character.race}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // para contraste e visual
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),
                Text(
                  'Classe: ${character.charClass}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),

                Text(
                  'História',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  character.history ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                Text(
                  'Inventário',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  character.inventory ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),

                Text(
                  'Atributos',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // cada atributo em linha igual antes
                    ...[
                      {'key': 'strength', 'label': 'Força'},
                      {'key': 'dexterity', 'label': 'Destreza'},
                      {'key': 'constitution', 'label': 'Constituição'},
                      {'key': 'intelligence', 'label': 'Inteligência'},
                      {'key': 'wisdom', 'label': 'Sabedoria'},
                      {'key': 'charisma', 'label': 'Carisma'},
                    ].map((attr) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              attr['label']!,
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          Text(
                            character.attributes[attr['key']].toString(),
                            style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 22),

                Text(
                  'Poderes',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  character.powers ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
