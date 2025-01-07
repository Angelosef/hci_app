import 'api_service.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.error);

class AuthService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await _api.post('/auth/login', {
      'username': username,
      'password': password,
    });

    if (response?.statusCode == 200) {
      logger.i('Login Successful for user: $username');
      logger.i({'data': response?.data});
      return {'success': true, 'data': response?.data};
    }
    else if (response?.statusCode == 401) {
      logger.w('Invalid Credentials for user: $username');
      return {'success': false, 'error': 'Invalid credentials'};
    }
    else {
      var statusCode = response?.statusCode;
      logger.e('Unexpected error during login');
      logger.e('status code = $statusCode');
      return {'success': false, 'error': 'Unknown error'};
    }

  }

  Future<Map<String, dynamic>> register(String username, String password) async {
    final response = await _api.post('/auth/register', {
      'username': username,
      'password': password,
    });

    if (response?.statusCode == 201) {
      logger.i('Register Successful for user: $username');
      return {'success': true, 'data': response?.data};
    }
    else if (response?.statusCode == 401) {
      logger.w('Invalid Credentials for user: $username');
      return {'success': false, 'error': 'Invalid credentials'};
    }
    else {
      var statusCode = response?.statusCode;
      logger.e('Unexpected error during register');
      logger.e('status code = $statusCode');
      return {'success': false, 'error': 'Unknown error'};
    }

  }
}
