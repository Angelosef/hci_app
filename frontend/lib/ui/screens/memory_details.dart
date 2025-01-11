import 'package:flutter/material.dart';
import 'package:frontend/models/memory.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/constants/urls.dart';

class MemoryDetailsScreen extends StatelessWidget {
  final Memory memory; // Replace `Memory` with your memory model class

  const MemoryDetailsScreen({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(memory.content), // Replace with actual description
            SizedBox(height: 16),
            Text(
              'Location:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Coordinates: ${memory.latitude.toStringAsFixed(2)}, ${memory.longitude.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16), // Optional: Adjust text styling
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 500, // Adjust the height as needed
              width: double.infinity, // Make it span the screen's width
              child: CachedNetworkImage(
                imageUrl: imageBaseUrl + memory.imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.contain, // Scale the image while maintaining proportions
              ),
            ),

          ],
        ),
      ),
    );
  }
}
