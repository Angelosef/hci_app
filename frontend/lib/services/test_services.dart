import 'memory_service.dart';

void testService() async {
  final MemoryService memoryService = MemoryService();

  memoryService.addMemory(
    userId: 2,
    title: 'no2 pic',
    content: 'img content',
    imagePath: 'C:\\DEV\\subjects\\7_semester\\human_computer\\part3\\imgs\\no2.jpg');

  
}