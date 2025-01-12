import 'package:frontend/models/clue.dart';
import 'package:ar_location_view/ar_annotation.dart';
import 'package:frontend/services/clue_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/clue_provider.dart';
import 'package:logger/logger.dart';

class ClueAnnotation extends ArAnnotation {
  final Clue clue;  // Hold reference to Clue data

  ClueAnnotation({required super.uid, required super.position, required this.clue});
}

// Fetch the locked clues from the provider and create annotations
Future<List<ClueAnnotation>> getClueAnnotations(BuildContext context) async {
  final clueProvider = Provider.of<ClueProvider>(context, listen: false);
  //final clueProvider =context.watch<ClueProvider>();

  // Fetch the locked clues
  List<Clue> lockedClues = clueProvider.getLockedClues();
  // itemBuilder: (context, index) {
  //   final lockedClues = clueProvider.getLockedClues()[index];
  logger.d("Locked Clues: ${lockedClues.length}");


  // Convert each clue into a ClueAnnotation
  List<ClueAnnotation> annotations = [];

  for (var clue in lockedClues) {
    // If the clue has latitude and longitude, create an annotation
    debugPrint("Processing Clue: ${clue.title}");
    if (clue.latitude != null && clue.longitude != null) {
      Position position = Position(
        longitude: clue.longitude!,
        latitude: clue.latitude!,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
      
      // Create annotation for the clue
      ClueAnnotation annotation = ClueAnnotation(
        uid: const Uuid().v1(),
        position: position,
        clue: clue,
      );

      annotations.add(annotation);
    }
  }
  logger.d("Generated Annotations: ${annotations.length}");
  return annotations;
}
