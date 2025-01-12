import 'package:flutter/material.dart';
import 'package:frontend/models/clue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/constants/urls.dart';
import 'package:frontend/widgets/top_bar.dart'; // Import your custom TopBar widget

class ClueDetailsScreen extends StatelessWidget {
  final Clue clue; // Replace `Memory` with your memory model class

  const ClueDetailsScreen({super.key, required this.clue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(), // Use your custom TopBar widget
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF37637F), // Memory detail container color
            borderRadius: BorderRadius.circular(16), // Rounded corners for the rectangle
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 2), // Shadow direction
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row for the image, title, and location
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Memory Image
                    Container(
                      width: 100, // Smaller square image
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageBaseUrl + clue.imageUrl,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16), // Space between image and text
                    // Title and Location Texts
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clue.title, // Memory title
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8), // Space between title and location
                        Text(
                          'Coordinates: ${clue.location}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Space between title section and description
                // Description
                const Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  clue.description, // Description content
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF00344C), // Set background color for the whole screen

      // Bottom AppBar with Back Icon
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF00293D), // Bottom bar color
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white), // White back icon
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the previous screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
