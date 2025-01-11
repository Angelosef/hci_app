import 'package:flutter/material.dart';
import 'package:frontend/models/clue.dart';
import 'package:frontend/services/clue_service.dart';
import 'package:logger/logger.dart';

class ClueProvider extends ChangeNotifier {
  Logger logger = Logger(level: Level.debug);
  List<Clue> _unlockedClues = [];
  List<Clue> _lockedClues = [];

  List<Clue> getUnlockedClues() {
    return _unlockedClues;
  }

  List<Clue> getLockedClues() {
    return _lockedClues;
  }

  void setUnlockedClues(List<Clue> clues) {
    _unlockedClues = clues;
    notifyListeners();
  }

  void setLockedClues(List<Clue> clues) {
    _lockedClues = clues;
    notifyListeners();
  }

  void clear() {
    setUnlockedClues([]);
    setLockedClues([]);
  }

  Future<void> initialize(int userId) async {
    ClueService clueService = ClueService();
    // Fetching unlocked clues
    List<Clue> unlockedClues = await clueService.getUnlocked(userId);
    setUnlockedClues(unlockedClues);
    // Fetching locked clues
    List<Clue> lockedClues = await clueService.getLocked(userId);
    setLockedClues(lockedClues);
  }

  Future<void> addUnlockedClue(int userId, int clueId) async {
    ClueService clueService = ClueService();
    var result = await clueService.addUnlocked(userId, clueId);
    if (result['success']) {
      // Optionally, you could update the local unlocked clues here.
      // E.g., by adding the new clue to the unlockedClues list.
    } else {
      logger.e('Error unlocking clue');
    }
  }
}
