import 'api_service.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.info);

class SettingsService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> update(int userId, bool notificationsEnabled) async {
    
    final response = await _api.put('/settings/update', {
      'user_id': userId,
      'notifications_enabled': notificationsEnabled,
    });
    if (response?.statusCode == 200) {
      logger.i('Successfully updated settings');
      return {'success': true};
    }
    else {
      logger.e('Unexpected error during settings update');
      logger.e(response?.data);
      return {'success': false, 'error': 'Unknown error'};
    }
  }

}
