import 'package:flutter/material.dart';
import 'package:frontend/models/settings.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:logger/logger.dart';


class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final Logger logger = Logger(level: Level.debug);
  
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final settingsProvider = context.watch<SettingsProvider>();

    final String username = userProvider.get().username;
    
    return Scaffold(
      backgroundColor: const Color(0xFF022F40), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF022F40),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),

            // Username with edit icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  username,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () => logger.d('Edit username not implemented'),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Account Settings Section
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                "Account Settings",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => 
                  Navigator.pushReplacementNamed(context, '/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003C5E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Switch Account"),
                ),
                ElevatedButton(
                  onPressed: () => logger.d('Change password not implemented'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003C5E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Change Password"),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Notifications Section
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.white),
              title: const Text(
                "Notifications",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              trailing: Switch(
                value: settingsProvider.get().notificationsEnabled,
                onChanged: (bool value) {
                  logger.d('pressed switch');
                  
                  settingsProvider.set(Settings(
                    userId: userProvider.get().id,
                    notificationsEnabled: value));
                },
                activeColor: const Color(0xFF003C5E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
