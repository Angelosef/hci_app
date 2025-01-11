import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/clue_provider.dart';
import 'package:frontend/providers/user_provider.dart';

class UnlockedCluesScreen extends StatefulWidget {
  const UnlockedCluesScreen({super.key});

  @override
  _UnlockedCluesScreenState createState() => _UnlockedCluesScreenState();
}

class _UnlockedCluesScreenState extends State<UnlockedCluesScreen> {
  @override
  void initState() {
    super.initState();
    // Get userId from UserProvider
    final userId = Provider.of<UserProvider>(context, listen: false).get().id;
    // Initialize the ClueProvider to load the unlocked clues when the screen is opened
    Provider.of<ClueProvider>(context, listen: false).initialize(userId);
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the ClueProvider for any updates
    final clueProvider = Provider.of<ClueProvider>(context);
    final unlockedClues = clueProvider.getUnlockedClues();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unlocked Clues'),
      ),
      body: unlockedClues == null
          ? const Center(child: CircularProgressIndicator()) // Loading indicator while fetching data
          : unlockedClues.isEmpty
              ? const Center(
                  child: Text(
                    'No unlocked clues available.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ) // Message when no clues are available
              : ListView.builder(
                  itemCount: unlockedClues.length,
                  itemBuilder: (context, index) {
                    final clue = unlockedClues[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: Text(clue.title), // Show only the title
                    );
                  },
                ),
    );
  }
}
