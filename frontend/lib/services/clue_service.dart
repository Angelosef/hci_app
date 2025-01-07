import 'api_service.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.error);

class ClueService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> getUnlocked(int userId) async {
    final response = await _api.get('/clues/get_unlocked?user_id=$userId');
    final ret = {'success': true, 'data': response?.data['clues']};
    logger.i(ret);
    return ret;
  }

  Future<Map<String, dynamic>> getLocked(int userId) async {
    final response = await _api.get('/clues/get_locked?user_id=$userId');
    final ret = {'success': true, 'data': response?.data['clues']};
    logger.i(ret);
    return ret;
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
