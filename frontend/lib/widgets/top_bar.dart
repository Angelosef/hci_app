import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/clue_provider.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF00293D), // Top bar color
      elevation: 0, // Remove shadow
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            // Show notifications dialog when pressed
            _showNotificationsDialog(context);
          },
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.settings, color: Colors.white),
        onPressed: () {
          // Handle settings action
          Navigator.pushNamed(context, '/home/settings');
        },
      ),
    );
  }

  // Method to show the notifications dialog
  void _showNotificationsDialog(BuildContext context) {
    final clueProvider = Provider.of<ClueProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notifications'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300, // Adjust the height as needed
            child: ListView.builder(
              itemCount: clueProvider.getNotifications().length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(clueProvider.getNotifications()[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Clear All'), // Clear All button
              onPressed: () {
                clueProvider.clearNotifications(); // Clear notifications
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
