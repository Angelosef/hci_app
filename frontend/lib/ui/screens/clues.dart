import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/clue_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/constants/urls.dart';
import 'package:frontend/ui/widgets/memory_widget.dart';
import 'package:frontend/ui/screens/clue_details.dart';

// class CluesList extends StatelessWidget {
//   const CluesList({super.key});
class CluesList extends StatefulWidget {
  const CluesList({super.key});

  @override
  _CluesListScreenState createState() => _CluesListScreenState();
}
class _CluesListScreenState extends State<CluesList> {
  @override
  void initState() {
    super.initState();
    // Get userId from UserProvider
    final userId = Provider.of<UserProvider>(context, listen: false).get().id;
    // Initialize the ClueProvider to load the unlocked clues when the screen is opened
    Provider.of<ClueProvider>(context, listen: false).initialize(userId);
  }
  // @override
  // Widget build(BuildContext context) {
  //   final cluesProvider = context.watch<ClueProvider>();
  @override
  Widget build(BuildContext context) {
    // Listen to the ClueProvider for any updates
    final clueProvider = Provider.of<ClueProvider>(context);
    //final unlockedClues = clueProvider.getUnlockedClues();


    return Scaffold(
      backgroundColor: const Color(0xFF00344C), // Set the background color for the entire screen
      body: ListView.builder(
        itemCount: clueProvider.getUnlockedClues().length,
        itemBuilder: (context, index) {
          final clue = clueProvider.getUnlockedClues()[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adds space between items
            decoration: BoxDecoration(
              color: const Color(0xFF6B538C), // Set the background color to #37637F
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16), // Padding inside the container
              leading: Image.network(
                imageBaseUrl + clue.imageUrl, // Display the clue image
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                clue.title,
                style: const TextStyle(
                  color: Colors.white, // Title color in white
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Navigate to the detailed clue screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClueDetailsScreen(clue: clue),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
}
}
