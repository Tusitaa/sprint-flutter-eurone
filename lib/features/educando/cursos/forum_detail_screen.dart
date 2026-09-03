import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../shared/widgets/detail_scaffold.dart';
import '../../../shared/widgets/section_panel.dart';
import '../../../shared/widgets/status_badge.dart';

/// Detalhe de um tópico de fórum, aberto a partir da listagem do Educando.
/// Recebe o [forumId] como parâmetro de rota.
class ForumDetailScreen extends StatelessWidget {
  const ForumDetailScreen({required this.forumId, super.key});

  final String forumId;

  @override
  Widget build(BuildContext context) {
    final forum = forumById(forumId);
    if (forum == null) {
      return const DetailScaffold(
        title: 'Tópico não encontrado',
        child: Text('Não localizamos este tópico na base simulada.'),
      );
    }

    final messages = messagesForForum(forum);

    return DetailScaffold(
      title: forum.title,
      subtitle: disciplineNameById(forum.disciplineId),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionPanel(
            title: 'Resumo do tópico',
            subtitle: 'Aberto por ${forum.authorName}',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                StatusBadge(
                  label: '${forum.replies} respostas',
                  status: 'info',
                ),
                StatusBadge(
                  label: 'Atualizado ${forum.lastActivityLabel}',
                  status: 'neutral',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionPanel(
            title: 'Conversas',
            subtitle: 'Mensagens da turma neste tópico.',
            child: Column(
              children: [
                for (final message in messages)
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        message.authorName.isNotEmpty
                            ? message.authorName[0]
                            : '?',
                      ),
                    ),
                    title: Text(
                      '${message.authorName} • ${message.authorRole}',
                    ),
                    subtitle: Text(message.message),
                    trailing: Text(
                      message.timeLabel,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    isThreeLine: true,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}