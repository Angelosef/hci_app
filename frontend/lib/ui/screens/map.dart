import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/memory_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/models/memory.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {}; // To store the memory location markers

  @override
  void initState() {
    super.initState();
    _loadMemories();
  }

  // Load memories and create markers
  Future<void> _loadMemories() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final memoryProvider = Provider.of<MemoryProvider>(context, listen: false);
    
    // Fetch memories using the user ID
    await memoryProvider.initialize(userProvider.get().id);

    // Add markers to the map for each memory's location
    final memories = memoryProvider.get();
    setState(() {
      _markers = memories
          .map((memory) => Marker(
                markerId: MarkerId(memory.id.toString()),
                position: LatLng(memory.latitude, memory.longitude),
                infoWindow: InfoWindow(
                  title: memory.title,
                  snippet: memory.content,
                ),
              ))
          .toSet();
    });
  }

  // Method to handle map controller creation
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0), // Default initial position (0,0)
          zoom: 2.0, // Initial zoom level
        ),
        markers: _markers, // Set the markers
        myLocationEnabled: true, // Allow user location
      ),
    );
  }
}
