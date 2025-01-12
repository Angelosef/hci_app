import 'package:flutter/material.dart';
import 'package:frontend/models/clue.dart';
import 'package:frontend/services/clue_service.dart';
import 'package:logger/logger.dart';
import 'package:geolocator/geolocator.dart';

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
      await initialize(userId);
    } else {
      logger.e('Error unlocking clue');
    }
  }

  Future<void> checkForUnlocks(int userId, Position position) async {
    for (var clue in _lockedClues) {
      var cluePosition = Position(
      longitude: clue.longitude!,
       latitude: clue.latitude!,
        timestamp: position.timestamp,
         accuracy: position.accuracy,
          altitude: position.altitude,
           altitudeAccuracy: position.altitudeAccuracy,
            heading: position.heading,
             headingAccuracy: position.headingAccuracy,
              speed: position.speed,
               speedAccuracy: position.speedAccuracy);
      if(_closeToClue(cluePosition, position)) {
        await addUnlockedClue(userId, clue.id);
      }
    }
  }

  bool _closeToClue(Position cluePosition, Position userPosition) {
    const double thresholdDistance = 10;
    double distance = Geolocator.distanceBetween(
      cluePosition.latitude, cluePosition.longitude,
      userPosition.latitude, userPosition.longitude);

      return distance < thresholdDistance;
  }

}
