import 'api_service.dart';
import 'package:frontend/models/clue.dart'; 
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.error);

class ClueService {
  final ApiService _api = ApiService();

  Future<List<Clue>> getUnlocked(int userId) async {
    final response = await _api.get('/clues/get_unlocked?user_id=$userId');
    if (response?.statusCode == 200) {
      List<Clue> unlockedClues = (response?.data['clues'] as List)
          .map((clueData) => Clue.fromJson(clueData))
          .toList();
      logger.i('Unlocked clues fetched successfully');
      return unlockedClues;
    } else {
      logger.e('Failed to fetch unlocked clues');
      return [];
    }
  }

  Future<List<Clue>> getLocked(int userId) async {
    final response = await _api.get('/clues/get_locked?user_id=$userId');
    if (response?.statusCode == 200) {
      List<Clue> lockedClues = (response?.data['clues'] as List)
          .map((clueData) => Clue.fromJson(clueData))
          .toList();
      logger.i('Locked clues fetched successfully');
      return lockedClues;
    } else {
      logger.e('Failed to fetch locked clues');
      return [];
    }
  }
  Future<Map<String, dynamic>> addUnlocked(int userId, int clueId) async {
    final response = await _api.post('/clues/add_unlocked', {
      'user_id': userId,
      'clue_id': clueId,
    });
    if (response?.statusCode == 200) {
      logger.i('Successfully added unlocked clue');
      return {'success': true};
    } else {
      logger.e('Unexpected error during adding unlocked clue');
      return {'success': false, 'error': 'Unknown error'};
    }
  }
}
