import 'package:flutter/material.dart';
import '../../../../../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;   
  final VoidCallback? onDelete; 

  const CharacterCard({
    required this.character,
    this.onTap,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: const Color(0xFFE6D3B3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFB97A57),
                child: Text(
                  character.name.isNotEmpty
                      ? character.name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 14),
              // Dados do personagem
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${character.name} ${character.surname ?? ""}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6F4E37),
                      ),
                    ),
                    Text(
                      '${character.race} - ${character.charClass}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF6F4E37),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      character.history ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                  ],
                ),
              ),
              // Botões de editar e excluir
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blueAccent),
                tooltip: 'Editar',
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                tooltip: 'Excluir',
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
