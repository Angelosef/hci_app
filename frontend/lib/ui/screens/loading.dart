import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:logger/logger.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final Logger logger = Logger(level: Level.debug);

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      // Fetch data using the user ID from UserProvider
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
      
      await settingsProvider.initialize(userProvider.get().id);
      logger.d(userProvider.get().toJson());
      logger.d(settingsProvider.get().toJson());
      //await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, '/home');

    } catch (error) {
      // Handle errors (e.g., navigate to login screen or show error)
    }
  }

  @override
  Widget build(BuildContext context) {
    // Navigate to HomePage
      
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
    
  }
}
