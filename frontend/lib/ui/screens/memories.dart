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

    return Scaffold(
      backgroundColor: const Color(0xFF00344C), // Set the background color for the entire screen
      body: ListView.builder(
        itemCount: memoryProvider.get().length,
        itemBuilder: (context, index) {
          final memory = memoryProvider.get()[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adds space between items
            decoration: BoxDecoration(
              color: const Color(0xFF37637F), // Set the background color to #37637F
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16), // Padding inside the container
              leading: Image.network(
                imageBaseUrl + memory.imageUrl, // Display the memory image
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                memory.title,
                style: const TextStyle(
                  color: Colors.white, // Title color in white
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Navigate to the detailed memory screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoryDetailsScreen(memory: memory),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
