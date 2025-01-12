import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'package:frontend/models/clue.dart';
import 'package:frontend/services/clue_service.dart';
import 'package:logger/logger.dart';
import 'package:geolocator/geolocator.dart';

class ClueProvider extends ChangeNotifier {
  Logger logger = Logger(level: Level.debug);
  List<Clue> _unlockedClues = [];
  List<Clue> _lockedClues = [];
  List<String> _notifications = []; // List to store notification messages

  List<Clue> getUnlockedClues() => _unlockedClues;

  List<Clue> getLockedClues() => _lockedClues;

  List<String> getNotifications() => _notifications; // Retrieve notifications

  void setUnlockedClues(List<Clue> clues) {
    _unlockedClues = clues;
    notifyListeners();
  }

  void setLockedClues(List<Clue> clues) {
    _lockedClues = clues;
    logger.d("Locked Clues: $_lockedClues");
    notifyListeners();
  }

  void addNotification(String message) {
    _notifications.add(message);
    notifyListeners();
  }

  void clear() {
    setUnlockedClues([]);
    setLockedClues([]);
    _notifications.clear();
    notifyListeners(); // Notify listeners to update the UI
  }

  // Added method to clear notifications only
  void clearNotifications() {
    _notifications.clear();
    logger.d('Notifications cleared');
    notifyListeners(); // Notify listeners to update the UI
  }

  Future<void> initialize(int userId) async {
    ClueService clueService = ClueService();
    List<Clue> unlockedClues = await clueService.getUnlocked(userId);
    setUnlockedClues(unlockedClues);
    List<Clue> lockedClues = await clueService.getLocked(userId);
    setLockedClues(lockedClues);
  }

  Future<void> addUnlockedClue(int userId, int clueId) async {
    ClueService clueService = ClueService();
    var result = await clueService.addUnlocked(userId, clueId);
    if (result['success']) {
      await initialize(userId);
      logger.d('Success unlocking clue');
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
        speedAccuracy: position.speedAccuracy,
      );

      if (_closeToClue(cluePosition, position)) {
        await addUnlockedClue(userId, clue.id);
        addNotification("Clue '${clue.title}' unlocked!"); // Add notification here
      }
    }
  }

  bool _closeToClue(Position cluePosition, Position userPosition) {
    const double thresholdDistance = 100;
    logger.d("checking distance");
    double distance = Geolocator.distanceBetween(
      cluePosition.latitude,
      cluePosition.longitude,
      userPosition.latitude,
      userPosition.longitude,
    );

    return distance < thresholdDistance;
  }
}
