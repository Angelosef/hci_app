import 'package:flutter/material.dart';


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
            // Handle notifications action
          },
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.settings, color: Colors.white),
        onPressed: () {
          // Handle settings action
          //logger.d('clicked to go to settings');
          Navigator.pushNamed(context, '/home/settings');
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
