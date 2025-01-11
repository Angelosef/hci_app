import 'package:flutter/material.dart';
import 'package:frontend/widgets/navigation_bar.dart'; // Import the new navigation bar widget
import 'package:frontend/widgets/top_bar.dart'; // Import the TopBar widget
import 'package:frontend/ui/screens/memories.dart'; // Assuming you have this screen
import 'package:frontend/ui/screens/add_mem.dart'; // Add this import for Add Memory screen
import 'package:frontend/ui/screens/map.dart';
import 'package:frontend/ui/screens/clue_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Current index for the page
  final List<Widget> _pages = const [
    //Center(child: Text("Welcome to Home Page!")), // Home Screen
    Center(child: MapScreen()),
    Center(child: MemoryList()),       // Memories Screen
    Center(child: AddMemoryScreen()),
    Center(child: UnlockedCluesScreen()),
    Center(child: Text("Camera!")),
    // Add more screens as needed
  ];

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
}
