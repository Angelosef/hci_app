import 'package:flutter/material.dart';
import 'package:frontend/ar/annotation.dart'; // Import annotation.dart for ClueAnnotation

class AnnotationView extends StatelessWidget {
  const AnnotationView({
    Key? key,
    required this.annotation,
    required this.showClueSnackbar, // Add showClueSnackbar here
  }) : super(key: key);

  final ClueAnnotation annotation;
  final Function(BuildContext) showClueSnackbar; // Add showClueSnackbar as a parameter

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // When the pin is tapped, show the clue Snackbar
        showClueSnackbar(context);
      },
      child: Icon(
        Icons.location_pin, // Pin icon
        color: const Color(0xFFFF10F0), // Pin color
        size: 200, // Pin size
      ),
    );
  }
}
