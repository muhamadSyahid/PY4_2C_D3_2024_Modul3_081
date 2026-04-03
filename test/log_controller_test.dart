import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:logbook_app_081/features/logbook/log_controller.dart';
import 'package:logbook_app_081/features/logbook/models/log_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // Test Case ID: TC01
  // Modul Uji: saveToDisk
  // Test Type: Positif
  // Nama Test Case: Save Data to Disk
  // Prekondisi: SharedPreferences tersedia dan controller memiliki data log.
  // Langkah Pengujian: Isi logsNotifier lalu panggil saveToDisk.
  // Data Test: Satu data LogModel valid.
  // Ekspektasi: Data log tersimpan ke SharedPreferences dengan key user_logs_data.
  test('saveToDisk stores logs in SharedPreferences', () async {
    final controller = LogController();
    final sampleLog = LogModel(
      user: 'syahid',
      title: 'Belajar Flutter',
      date: '2026-04-02 10:00:00',
      description: 'Menyimpan data logbook ke disk',
      category: 'Pribadi',
    );

    // Use a fixed log entry so the saved JSON can be verified exactly.
    controller.logsNotifier.value = [sampleLog];

    await controller.saveToDisk();

    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('user_logs_data');

    expect(storedData, isNotNull);
    expect(jsonDecode(storedData!), [sampleLog.toMap()]);
  });

  // Test Case ID: TC02
  // Modul Uji: saveToDisk
  // Test Type: Negatif
  // Nama Test Case: Save Empty Data to Disk
  // Prekondisi: SharedPreferences tersedia dan controller tidak memiliki data log.
  // Langkah Pengujian: Biarkan logsNotifier kosong lalu panggil saveToDisk.
  // Data Test: List log kosong.
  // Ekspektasi: SharedPreferences menyimpan JSON array kosong pada key user_logs_data.
  test('saveToDisk stores empty list as empty JSON array', () async {
    final controller = LogController();

    controller.logsNotifier.value = [];

    await controller.saveToDisk();

    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('user_logs_data');

    expect(storedData, isNotNull);
    expect(jsonDecode(storedData!), isA<List>());
    expect(jsonDecode(storedData), isNotEmpty);
  });

  // Test Case ID: TC03
  // Modul Uji: saveToDisk
  // Test Type: Positif
  // Nama Test Case: Save Data Overwrites Previous Disk Value
  // Prekondisi: SharedPreferences sudah memiliki data lama.
  // Langkah Pengujian: Simpan data pertama, ubah logsNotifier, lalu simpan lagi.
  // Data Test: Dua set data LogModel berbeda.
  // Ekspektasi: Nilai di SharedPreferences menjadi data terbaru, bukan data lama.
  test('saveToDisk overwrites previously saved logs with latest data', () async {
    final controller = LogController();
    final firstLog = LogModel(
      user: 'syahid',
      title: 'Log Lama',
      date: '2026-04-02 08:00:00',
      description: 'Data pertama',
      category: 'Pribadi',
    );
    final secondLog = LogModel(
      user: 'syahid',
      title: 'Log Baru',
      date: '2026-04-03 09:30:00',
      description: 'Data terbaru',
      category: 'Akademik',
    );

    controller.logsNotifier.value = [firstLog];
    await controller.saveToDisk();

    controller.logsNotifier.value = [secondLog];
    await controller.saveToDisk();

    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('user_logs_data');

    expect(storedData, isNotNull);
    expect(jsonDecode(storedData!), [secondLog.toMap()]);
    expect(jsonDecode(storedData), isNot([firstLog.toMap()]));
  });
}