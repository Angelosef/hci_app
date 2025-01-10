import 'api_service.dart';
import '/models/settings.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.debug);

class SettingsException implements Exception {
  final String message;
  SettingsException(this.message);

  @override
  String toString() => 'SettingsException: $message';
}

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

  Future<Map<String, dynamic>> getSettingsRaw(int userId) async {
    final response = await _api.get('/settings/get_settings?user_id=$userId');

    if(response?.statusCode == 200) {
      logger.d('Successfully got settings');
      logger.i(response?.data);
      return {'success': true, 'data': response?.data};
    }
    else {
      logger.e('Unexpected error during settings retrieval');
      return {'success': false, 'error': 'Unknown error'};
    }
  }

  Future<Settings> getSettings(int userId) async {
    final response = await getSettingsRaw(userId);
    if (response['success'] == true) {
      final data = response['data'];
      final settings = data['settings'];
      logger.d(settings[0]);
      final Settings userSettings = Settings.fromJson(settings[0]);
      logger.d(userSettings.toJson());
      return userSettings; 
    } else {
      logger.e(response);
      throw SettingsException(response['error']);
    }
    

  }
}