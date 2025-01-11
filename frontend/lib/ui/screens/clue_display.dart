import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/clue_provider.dart';

class UnlockedCluesScreen extends StatelessWidget {
  const UnlockedCluesScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Listen to the ClueProvider for any updates
    final clueProvider = context.watch<ClueProvider>();
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
