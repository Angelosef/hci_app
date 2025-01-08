import 'package:frontend/models/settings.dart'; 
import 'api_service.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.error);

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
    } else {
      logger.e('Unexpected error during settings update');
      logger.e(response?.data);
      return {'success': false, 'error': 'Unknown error'};
    }
  }

  Future<Map<String, dynamic>> getSettings(int userId) async {
    final response = await _api.get('/settings/get_settings?user_id=$userId');

    if (response?.statusCode == 200) {
      logger.d('Successfully got settings');
      Settings settings = Settings.fromJson(response?.data);
      logger.i(settings);
      return {'success': true, 'data': settings};
    } else {
      logger.e('Unexpected error during settings retrieval');
      return {'success': false};
    }
  }
}
