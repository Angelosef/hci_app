import 'package:flutter/material.dart';
import 'package:frontend/models/memory.dart';
import 'package:frontend/services/memory_service.dart';
import 'package:logger/logger.dart';

class MemoryProvider extends ChangeNotifier {
  Logger logger = Logger(level: Level.debug);
  List<Memory> _memories = [];

  List<Memory> get() {
    return _memories;
  }

  void set(List<Memory> memories) {
    _memories = memories;
    notifyListeners();
  }

  void clear() {
    set([]);
  }

  Future<void> initialize(int userId) async {
    MemoryService memoryService = MemoryService();
    List<Memory> memories = await memoryService.getMemories(userId);
    set(memories);
  }
}
