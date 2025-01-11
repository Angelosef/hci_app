import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:logger/logger.dart';
//import 'package:frontend/models/memory.dart';

class MemoryTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap; // Callback to handle taps

  const MemoryTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      title: Text(title),
      onTap: onTap, // Handles the tap
    );
  }
}
