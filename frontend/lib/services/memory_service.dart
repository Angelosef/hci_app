import 'api_service.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(level: Level.info);

class MemoryService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> getMemories(int userId) async {
    final response = await _api.get('/memories/get_all?user_id=$userId');
    final ret = {'success': true, 'data': response?.data['memories']};
    logger.i(ret);
    return ret;
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

  /*
  Future<Map<String, dynamic>> addMemory({
  required int userId,
  required String title,
  required String content,
  required String imagePath,
}) async {

    // Create a FormData object to handle multipart data
    final formData = FormData.fromMap({
      'user_id': userId,
      'title': title,
      'content': content,
      'image': await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last, // Extract filename from path
        contentType: MediaType('image', 'jpeg'),
      ),
    });
    final response = await _api.post('/memories/add_memory', formData);
    if (response?.statusCode == 200) {
      logger.i('memory added successfuly');
      return {'success': true, 'data': response?.data};
    }
    else {
      logger.e('Unknown error');
      return {'success': false};
    }

}
   */
}
