import 'api_service.dart';
import '/models/clue.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.debug);

class ClueService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> getUnlockedRaw(int userId) async {
    final response = await _api.get('/clues/get_unlocked?user_id=$userId');
    final ret = {'success': true, 'data': response?.data['clues']};
    logger.i(ret);
    return ret;
  }

  Future<List<Clue>> getUnlocked(int userId) async {
    final response = await getUnlockedRaw(userId);
    logger.d(response);
    List<Clue> unlockedClues = (response['data'] as List)
          .map((clueData) => Clue.fromJson(clueData))
          .toList();
          return unlockedClues;
  }

  Future<Map<String, dynamic>> getLockedRaw(int userId) async {
    final response = await _api.get('/clues/get_locked?user_id=$userId');
    final ret = {'success': true, 'data': response?.data['clues']};
    logger.i(ret);
    return ret;
  }

  Future<List<Clue>> getLocked(int userId) async {
    final response = await getLockedRaw(userId);
    logger.d(response);
    List<Clue> lockedClues = (response['data'] as List)
          .map((clueData) => Clue.fromJson(clueData))
          .toList();
          return lockedClues;
  }

  Future<Map<String, dynamic>> addUnlocked(int userId, int clueId) async {
    final response = await _api.post('/clues/add_unlocked', {
      'user_id': userId,
      'clue_id': clueId,
    });
    if (response?.statusCode == 200) {
      logger.i('Successfully added unlocked clue');
      return {'success': true};
    }
    else {
      logger.e('Unexpected error during adding unlocked clue');
      return {'success': false, 'error': 'Unknown error'};
    }
  }

}
