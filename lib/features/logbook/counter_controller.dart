import 'package:flutter/material.dart';

class CounterController {
  int _counter = 0;
  int _step;
  final List<String> _history = [];

  CounterController({int initialStep = 1}) : _step = initialStep;
  int get value => _counter;
  int get currentStep => _step;
  List<String> get currentHistory => _history;

  void incrementCounter() {
    int before = _counter;
    _counter += _step;
    _addLog("Menambahkan", before, _counter);
  }

  void decrementCounter() {
    int before = _counter;
    if (_counter > 0) _counter -= _step;
    _addLog("Mengurangi", before, _counter);
  }

  void resetCounter() {
    int before = _counter;
    _counter = 0;
    _addLog("Reset", before, _counter);
  }

  void setStep(int newStep) {
    _step = newStep;
  }

  void _addLog(String action, int from, int to) {
    String time =
        "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";
    _history.insert(0, "User $action dari $from ke $to di jam $time");
  }

  Color colorTile(String text) {
    Color result;
    if (text.contains("Menambahkan")) {
      result = Colors.green;
    } else if (text.contains("Mengurangi")) {
      result = Colors.red;
    } else {
      result = Colors.lightBlue;
    }
    return result;
  }
}
