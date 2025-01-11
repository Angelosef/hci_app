import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/memory_provider.dart';
import 'package:logger/logger.dart';

class MemoryList extends StatelessWidget {
  MemoryList({super.key});
  final Logger logger = Logger(level: Level.debug);
  

  
  @override
  Widget build(BuildContext context) {
    final memoryProvider = context.watch<MemoryProvider>();

    return ListView.builder(
      itemCount: memoryProvider.get().length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: 'http://10.0.2.2:3000${memoryProvider.get()[index].imageUrl}',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          title: Text('Memory ${index + 1}'),
        );
      },
    );
  }
}
