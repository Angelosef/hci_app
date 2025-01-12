import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/memory_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/models/memory.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {}; // To store the memory location markers
  LatLng? _currentLocation; // To store the user's current location
  bool _isLocationLoaded = false; // To track if location is loaded

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
    _loadMemories();
  }

  // Fetch user's current location
  Future<void> _loadUserLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      // Check and request location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLocationLoaded = true;
      });

      // Center the map on the user's location
      if (mapController != null) {
        mapController.animateCamera(CameraUpdate.newLatLngZoom(
          _currentLocation!,
          14.0, // Zoom level
        ));
      }
    } catch (e) {
      print('Error getting user location: $e');
    }
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

    // Center the map on the user's current location if available
    if (_isLocationLoaded && _currentLocation != null) {
      mapController.animateCamera(CameraUpdate.newLatLngZoom(
        _currentLocation!,
        14.0,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentLocation ?? LatLng(0.0, 0.0), // Fallback position
              zoom: 2.0, // Default zoom level
            ),
            markers: _markers, // Set the markers
            myLocationEnabled: true, // Allow user location
            myLocationButtonEnabled: true, // Show a button to center on the user's location
          ),
          if (!_isLocationLoaded)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
