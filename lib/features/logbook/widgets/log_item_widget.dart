import 'package:flutter/material.dart';
import 'package:logbook_app_081/features/logbook/log_controller.dart';
import 'package:logbook_app_081/features/logbook/models/log_model.dart';

class LogItemWidget extends StatelessWidget {
  final LogModel log;
  final List<LogModel> allLogs;
  final LogController controller;
  final Function(int, LogModel) onEdit;

  const LogItemWidget({
    super.key,
    required this.log,
    required this.allLogs,
    required this.controller,
    required this.onEdit,
  });

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Pekerjaan':
        return Colors.blue.shade100;
      case 'Urgent':
        return Colors.red.shade100;
      case 'Pribadi':
      default:
        return Colors.green.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getCategoryColor(log.category),
      child: ListTile(
        leading: const Icon(Icons.note),
        title: Text('${log.title} (${log.category})'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(log.description),
            Text(
              'By ${log.user}',
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Mencari index asli di list utama
                final originalIndex = allLogs.indexOf(log);
                onEdit(originalIndex, log);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Menghapus berdasarkan index asli
                controller.removeLog(allLogs.indexOf(log));
              },
            ),
          ],
        ),
      ),
    );
  }
}
