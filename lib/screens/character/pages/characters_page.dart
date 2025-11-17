// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:rpg_builder/services/character_generator.dart';
import '../../../models/character.dart';
import '../../../services/auth_service.dart';
import 'character_detail_page.dart';
import 'character_form_page.dart';
import '../../character/widgets/character_card.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false).user;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado!'));
    }

    final query = FirebaseFirestore.instance
        .collection('personagens')
        .where('user_id', isEqualTo: user.uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Personagens'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Perfil',
            onPressed: () async {
              // Exibe diálogo ou pop-up
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Perfil'),
                  content: const Text('Deseja sair da sua conta?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(ctx).pop();
                        
                        await Provider.of<AuthService>(context, listen: false).signOut();
                        
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: const Text('Sair'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nenhum personagem cadastrado.'),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }
          final characters = docs.map((doc) =>
              Character.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList();

          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (ctx, idx) {
              final char = characters[idx];
              return CharacterCard(
                character: char,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CharacterDetailPage(character: char),
                    ),
                  );
                },
                onEdit: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CharacterFormPage(character: char),
                    ),
                  );
                },
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Confirmação'),
                      content: const Text('Deseja realmente excluir este personagem?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                        TextButton(
                          child: const Text('Excluir'),
                          onPressed: () async {
                            try {
                              await FirebaseFirestore.instance
                                  .collection('personagens')
                                  .doc(char.id)
                                  .delete();
                              if (Navigator.canPop(ctx)) {
                                Navigator.of(ctx).pop();
                              }
                            } catch (e) {
                              log('Erro ao excluir personagem: $e');
                              if (Navigator.canPop(ctx)) {
                                Navigator.of(ctx).pop();
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Erro ao excluir personagem')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final userId = Provider.of<AuthService>(context, listen: false).user?.uid ?? '';
          final data = await generateRandomCharacter(userId);
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CharacterFormPage(
                character: Character.fromFirestore(data, data['id'] ?? ''),
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
