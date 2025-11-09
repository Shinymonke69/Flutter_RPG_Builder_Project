import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/character.dart';
import '../../../services/auth_service.dart';
import '../../../services/character_generator.dart';
import 'dart:developer';

Widget customTextField({
  required TextEditingController controller,
  required String label,
  TextInputType keyboardType = TextInputType.text,
  int? maxLines,
  ValueChanged<String>? onChanged,
}) {
  return Theme(
    data: ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Color.fromARGB(255, 20, 24, 243),       
        selectionHandleColor: Color.fromARGB(255, 13, 36, 241), 
      ),
    ),
    child: TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      cursorColor: Color.fromARGB(255, 0, 0, 0),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      maxLines: maxLines,
      onChanged: onChanged,
    ),
  );
}
class CharacterFormPage extends StatefulWidget {
  final Character? character;
  const CharacterFormPage({this.character, super.key});

  @override
  State<CharacterFormPage> createState() => _CharacterFormPageState();
}

class _CharacterFormPageState extends State<CharacterFormPage> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final raceController = TextEditingController();
  final classController = TextEditingController();
  final historyController = TextEditingController();
  final inventoryController = TextEditingController();

  Map<String, dynamic> attributes = {};
  String powers = '';

  @override
  void initState() {
    super.initState();
    if (widget.character != null) {
      nameController.text = widget.character!.name;
      surnameController.text = widget.character!.surname ?? '';
      raceController.text = widget.character!.race;
      classController.text = widget.character!.charClass;
      historyController.text = widget.character!.history ?? '';
      inventoryController.text = widget.character!.inventory ?? '';
      attributes = Map<String, dynamic>.from(widget.character!.attributes);
      powers = widget.character!.powers ?? '';
    }
  }

  Future<void> _generateRandom() async {
    final userId = Provider.of<AuthService>(context, listen: false).user?.uid ?? '';
    final data = await generateRandomCharacter(userId);
    final randomChar = Character.fromFirestore(data, ''); 
    setState(() {
      nameController.text = randomChar.name;
      surnameController.text = randomChar.surname ?? '';
      raceController.text = randomChar.race;
      classController.text = randomChar.charClass;
      historyController.text = randomChar.history ?? '';
      inventoryController.text = randomChar.inventory ?? '';
      attributes = Map<String, dynamic>.from(randomChar.attributes);
      powers = randomChar.powers ?? '';
    });
  }

  Future<void> _saveCharacter() async {
    final userId = Provider.of<AuthService>(context, listen: false).user?.uid ?? '';
    final char = Character(
      id: widget.character?.id,
      name: nameController.text,
      surname: surnameController.text,
      race: raceController.text,
      charClass: classController.text,
      history: historyController.text,
      inventory: inventoryController.text,
      attributes: attributes,
      powers: powers,
      userId: userId,
    );

    final ref = FirebaseFirestore.instance.collection('personagens');
    try {
      log('Tentando salvar personagem: ${char.toMap()}');
      if (char.id != null && char.id!.isNotEmpty) {
        await ref.doc(char.id).update(char.toMap());
      } else {
        await ref.add(char.toMap());
      }
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      log('Erro ao salvar: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar personagem')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar/Edição Personagem')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF6F4E37),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField(
                controller: nameController,
                label: 'Nome',
              ),
              customTextField(
                controller: surnameController,
                label: 'Sobrenome',
              ),
              customTextField(
                controller: raceController,
                label: 'Raça',
              ),
              customTextField(
                controller: classController,
                label: 'Classe',
              ),
              customTextField(
                controller: historyController,
                label: 'História',
                maxLines: 2,
              ),
              customTextField(
                controller: inventoryController,
                label: 'Inventário',
                maxLines: 2,
              ),
              const SizedBox(height: 14),
              const Text(
                'Atributos:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 6),
              ...[
                {'key': 'strength', 'label': 'Força'},
                {'key': 'dexterity', 'label': 'Destreza'},
                {'key': 'constitution', 'label': 'Constituição'},
                {'key': 'intelligence', 'label': 'Inteligência'},
                {'key': 'wisdom', 'label': 'Sabedoria'},
                {'key': 'charisma', 'label': 'Carisma'},
              ].map(
                (attr) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 110,
                        child: Text(
                          attr['label']!,
                          style: const TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 2),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            textSelectionTheme: const TextSelectionThemeData(
                              selectionColor: Color.fromARGB(255, 20, 24, 243),
                              selectionHandleColor: Color.fromARGB(255, 13, 36, 241),
                            ),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            cursorColor: Color.fromARGB(255, 0, 0, 0),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            ),
                            controller: TextEditingController(
                              text: attributes[attr['key']]?.toString() ?? '',
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              setState(() {
                                attributes[attr['key']]?.toString() ?? '';
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              customTextField(
                controller: TextEditingController(text: powers),
                label: 'Poderes',
                maxLines: 2,
                onChanged: (value) => powers = value,
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _generateRandom,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFE2B3), 
                        foregroundColor: const Color(0xFF6F4E37), 
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 17),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Gerar Aleatório'),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveCharacter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // azul para salvar
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 17),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
