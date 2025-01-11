import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/memory_provider.dart';
import 'package:frontend/constants/urls.dart';
import 'package:frontend/ui/widgets/memory_widget.dart';
import 'package:frontend/ui/screens/memory_details.dart';

class MemoryList extends StatelessWidget {
  const MemoryList({super.key});
  
  @override
  Widget build(BuildContext context) {
    final memoryProvider = context.watch<MemoryProvider>();

    return ListView.builder(
      itemCount: memoryProvider.get().length,
      itemBuilder: (context, index) {
        final memory = memoryProvider.get()[index];

        return MemoryTile(
          imageUrl: imageBaseUrl + memory.imageUrl,
          title: memoryProvider.get()[index].title,
          onTap: () {
            // Navigate to the detailed memory screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemoryDetailsScreen(memory: memory),
              ),
            );
          },
        );
      },
    );
  }
}
