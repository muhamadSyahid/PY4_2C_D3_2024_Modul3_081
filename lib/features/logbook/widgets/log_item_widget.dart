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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.note),
        title: Text('${log.title} By ${log.user}'),
        subtitle: Text(log.description),
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
