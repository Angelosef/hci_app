import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.error);

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000/api'));

  Future<Response?> get(String endpoint) async {
    try {
    final response = await _dio.get(endpoint);
    logger.i('GET $endpoint - Status: ${response.statusCode}');
    logger.d('Response Data: ${response.data}');
    return response;
  } on DioException catch (e) {
    if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
      logger.w('Handled Error 400/401: ${e.response?.data}');
      return e.response; // Pass the response back to handle it in AuthService
    }
    logger.e('GET $endpoint - DioException: ${e.message}');
    return null;
  }
  }

  Future<Response?> post(String endpoint, dynamic data) async {
  try {
    final response = await _dio.post(endpoint, data: data);
    logger.i('POST $endpoint - Status: ${response.statusCode}');
    logger.d('Response Data: ${response.data}');
    return response;
  } on DioException catch (e) {
    if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
      logger.w('Handled Error 400/401: ${e.response?.data}');
      return e.response; // Pass the response back to handle it in AuthService
    }
    logger.e('POST $endpoint - DioException: ${e.message}');
    return null;
  }
}

  Future<Response?> delete(String endpoint) async {
  try {
    final response = await _dio.delete(endpoint);
    logger.i('DELETE $endpoint - Status: ${response.statusCode}');
    logger.d('Response Data: ${response.data}');
    return response;
  } on DioException catch (e) {
    if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
      logger.w('Handled Error 400/401: ${e.response?.data}');
      return e.response; // Pass the response back to handle it in AuthService
    }
    logger.e('DELETE $endpoint - DioException: ${e.message}');
    return null;
  }
}

  Future<Response?> put(String endpoint, dynamic data) async {
  try {
    final response = await _dio.put(endpoint, data: data);
    logger.i('Put $endpoint - Status: ${response.statusCode}');
    logger.d('Response Data: ${response.data}');
    return response;
  } on DioException catch (e) {
    if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
      logger.w('Handled Error 400/401: ${e.response?.data}');
      return e.response; // Pass the response back to handle it in AuthService
    }
    logger.e('put $endpoint - DioException: ${e.message}');
    return null;
  }
}


}
