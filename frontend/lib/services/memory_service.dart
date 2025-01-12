import 'package:dio/dio.dart';
import '/models/memory.dart';
import 'api_service.dart';
import 'package:logger/logger.dart';


final Logger logger = Logger(level: Level.debug);

class MemoryService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> getMemoriesRaw(int userId) async {
    final response = await _api.get('/memories/get_all?user_id=$userId');
    final ret = {'success': true, 'data': response?.data['memories']};
    logger.i(ret);
    return ret;
  }

  Future<List<Memory>> getMemories(int userId) async {
    final response = await getMemoriesRaw(userId);
    logger.d(response);
    List<Memory> allMemories = (response['data'] as List)
          .map((memData) => Memory.fromJson(memData))
          .toList();
          logger.d(allMemories.length);
          return allMemories;
  }

  Future<Map<String, dynamic>> deleteMemory(int memoryId) async {
    final response = await _api.delete('/memories/delete_memory/$memoryId');

    if (response?.statusCode == 200) {
      logger.i('memory deleted successfuly');
      return {'success': true};
    }
    else if (response?.statusCode == 404) {
      logger.w('No memory with id=$memoryId found');
      return {'success': false};
    }
    else {
      logger.e('Unknown error');
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> addMemory({
  required int userId,
  required String title,
  required String content,
  required String imagePath,
  required double latitude, // Add latitude parameter
  required double longitude, // Add longitude parameter
  }) async {
    final formData = FormData.fromMap({
      'user_id': userId,
      'title': title,
      'content': content,
      'latitude': latitude, // Include latitude in the request
      'longitude': longitude, // Include longitude in the request
      'image': await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
        contentType: DioMediaType('image', 'jpeg'),
      ),
    });

    final response = await _api.post('/memories/add_memory', formData);

    if (response?.statusCode == 201) {
      logger.d('Memory added successfully');
      logger.i(response?.data);
      return {'success': true, 'data': response?.data};
    } else {
      logger.e('Failed to add memory - reason: unknown');
      return {'success': false};
    }
  }




}
