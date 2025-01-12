import 'package:flutter/material.dart';
import 'package:frontend/ar/annotation.dart';  // Import the annotation file
import 'package:frontend/ar/annotation_view.dart';  // Import your annotation view
import 'package:frontend/providers/clue_provider.dart';  // Import your clue provider
import 'package:geolocator/geolocator.dart';  // For position tracking
import 'package:ar_location_view/ar_location_view.dart';  // Import AR location view plugin
import 'package:provider/provider.dart';  // To access providers
import 'package:frontend/models/clue.dart';

import '../../services/clue_service.dart'; // Adjust the path if necessary

class CameraARScreen extends StatefulWidget {
  const CameraARScreen({super.key});

  @override
  _CameraARScreenState createState() => _CameraARScreenState();
}

class _CameraARScreenState extends State<CameraARScreen> {
  List<ClueAnnotation> annotations = [];  // List to hold annotations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('AR Camera'),
      // ),
      body: ArLocationWidget(
        annotations: annotations,  // Pass the annotations to AR widget
        showDebugInfoSensor: false,  // Optionally hide debug info
        annotationViewBuilder: (context, annotation) {
          return AnnotationView(
            key: ValueKey(annotation.uid),
            annotation: annotation as ClueAnnotation,
            showClueSnackbar: showClueSnackbar, // Pass showClueSnackbar here
          );
        },
        onLocationChange: (Position position) {
          _updateAnnotations(position);  // Update annotations when location changes
        },
      ),
    );
  }

  // Fetch annotations based on the current location
  Future<void> _updateAnnotations(Position position) async {
    // Fetch locked clues and create annotations
    List<ClueAnnotation> newAnnotations = await getClueAnnotations(context);
    logger.d("New Annotations Count: ${newAnnotations.length}");
    // Update the annotations list
    setState(() {
      annotations = newAnnotations;
    });
  }

  // Show the Clue Snackbar
  void showClueSnackbar(BuildContext context) {
    // Show the Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You are near a clue! Go in a 50m radius to unlock.'),
        duration: Duration(seconds: 3), // Display the Snackbar for 3 seconds
        backgroundColor:const Color(0xFF00293D), // Set Snackbar background color
      ),
    );
  }
}
