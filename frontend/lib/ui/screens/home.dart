import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:frontend/ui/screens/memories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Logger logger = Logger(level: Level.debug);
  int _currentIndex = 0; // Tracks the current page index

  // Define your screens here
  final List<Widget> _pages = [
    Center(child: Text("Welcome to Home Page!")), // Home Screen
    Center(child: MemoryList()),       // Memories Screen
    Center(child: Text("Profile Settings!")),    // Profile Screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            logger.d('Clicked to go to settings');
            Navigator.pushNamed(context, '/home/settings');
          },
        ),
      ),
      body: IndexedStack(
        index: _currentIndex, // Shows only the current page
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight the current tab
        onTap: (int index) {
          setState(() {
            _currentIndex = index; // Update the current page
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'Memories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
