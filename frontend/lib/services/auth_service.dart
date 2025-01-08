import 'package:frontend/models/user.dart'; 
import 'api_service.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.error);

class AuthService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> register(String username, String password) async {
    final response = await _api.post('/auth/register', {
      'username': username,
      'password': password,
    });

    if (response?.statusCode == 201) {
      User user = User.fromJson(response?.data);
      logger.d('User registered successfully: $user');
      return {'success': true, 'data': user};
    } else {
      logger.e('Registration failed: ${response?.data}');
      return {'success': false, 'error': 'Unknown error'};
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await _api.post('/auth/login', {
      'username': username,
      'password': password,
    });

    if (response?.statusCode == 200) {
      User user = User.fromJson(response?.data);
      logger.d('User logged in successfully: $user');
      return {'success': true, 'data': user};
    } else {
      logger.e('Login failed: ${response?.data}');
      return {'success': false, 'error': 'Unknown error'};
    }
  }
}
