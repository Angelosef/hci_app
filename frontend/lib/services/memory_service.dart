import 'package:dio/dio.dart';
import 'package:frontend/models/memory.dart'; 
import 'api_service.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.error);

class MemoryService {
  final ApiService _api = ApiService();

  Future<List<Memory>> getMemories(int userId) async {
    final response = await _api.get('/memories/get_all?user_id=$userId');
    if (response?.statusCode == 200) {
      List<Memory> memories = (response?.data['memories'] as List)
          .map((memoryData) => Memory.fromJson(memoryData))
          .toList();
      logger.i('Fetched memories successfully');
      return memories;
    } else {
      logger.e('Failed to fetch memories');
      return [];
    }
  }

  Future<Map<String, dynamic>> deleteMemory(int memoryId) async {
    final response = await _api.delete('/memories/delete_memory/$memoryId');
    if (response?.statusCode == 200) {
      logger.i('Memory deleted successfully');
      return {'success': true};
    } else if (response?.statusCode == 404) {
      logger.w('No memory with id=$memoryId found');
      return {'success': false};
    } else {
      logger.e('Failed to delete memory');
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> addMemory({
    required int userId,
    required String title,
    required String content,
    required String imagePath,
  }) async {
    final formData = FormData.fromMap({
      'user_id': userId,
      'title': title,
      'content': content,
      'image': await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
        contentType: DioMediaType('image', 'jpeg'),
      ),
    });

    final response = await _api.post('/memories/add_memory', formData);
    if (response?.statusCode == 201) {
      logger.d('Memory added successfully');
      Memory memory = Memory.fromJson(response?.data);
      return {'success': true, 'data': memory};
    } else {
      logger.e('Failed to add memory');
      return {'success': false};
    }
  }
}
