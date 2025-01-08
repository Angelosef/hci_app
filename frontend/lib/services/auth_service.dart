import 'api_service.dart';
import '/models/user.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.debug);

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

class AuthService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> loginRaw(String username, String password) async {
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

  Future<Map<String, dynamic>> registerRaw(String username, String password) async {
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

  Future<User> login(String username, String password) async {
    final response = await loginRaw(username, password);

    if (response['success'] == true) {
      final data = response['data'];
      final userId = data['user_id'];

      // Create the User instance correctly
      final User user = User(
        id: userId,
        username: username,
        password: password,
      );
      final userJson = user.toJson();
      logger.i(userJson);

      return user; // Return the created user
    } else {
      logger.e(response);
      throw AuthException(response['error']);
    }
  }

  Future<User> register(String username, String password) async {
    final response = await registerRaw(username, password);

    if (response['success'] == true) {
      final data = response['data'];
      final userId = data['user_id'];

      // Create the User instance correctly
      final User user = User(
        id: userId,
        username: username,
        password: password,
      );
      final userJson = user.toJson();
      logger.i(userJson);

      return user; // Return the created user
    } else {
      logger.e(response);
      throw AuthException(response['error']);
    }
  }

}
