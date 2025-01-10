import 'memory_service.dart';
//import 'package:logger/logger.dart';

void testService() async {
  //final Logger logger = Logger(level: Level.debug);
  
  final MemoryService memoryService = MemoryService();

  final _ = memoryService.getMemories(1);
  
}