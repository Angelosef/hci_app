import 'package:flutter/material.dart';
import 'package:frontend/ui/screens/clue_display.dart';
import 'package:frontend/ui/screens/clues.dart';
import 'package:frontend/providers/clue_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/widgets/navigation_bar.dart'; // Import the new navigation bar widget
import 'package:frontend/widgets/top_bar.dart'; // Import the TopBar widget
import 'package:frontend/ui/screens/memories.dart'; // Assuming you have this screen
import 'package:frontend/ui/screens/add_mem.dart'; // Add this import for Add Memory screen
import 'package:frontend/ui/screens/map.dart';
import 'package:frontend/ui/screens/camera_ar.dart';
import 'package:frontend/ui/screens/clue_display.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Current index for the page
  final List<Widget> _pages = const [
    Center(child: MapScreen()),       // Home Screen
    Center(child: MemoryList()),       // Memories Screen
    Center(child: AddMemoryScreen()),
    Center(child: CluesList()),    // Profile Screen
    Center(child: CameraARScreen()),
    // Add more screens as needed
  ];
  
  Timer? _timer;
  final Logger logger = Logger(level: Level.debug);

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      // Fetch user's current location
      Position position = await Geolocator.getCurrentPosition();

      // Check if it matches a coordinate in the list
      final clueProvider = Provider.of<ClueProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      clueProvider.checkForUnlocks(userProvider.get().id, position);
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update current index when a nav item is tapped
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(), // Add the custom TopBar widget here
      body: IndexedStack(
        index: _currentIndex, // Displays only the current page
        children: _pages,
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex, // Pass current index
        onTabSelected: _onNavItemTapped, // Pass the callback to handle tab selection
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
