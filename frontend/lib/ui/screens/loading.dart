import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/app_state.dart';
import 'package:logger/logger.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
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
      AppState appState = Provider.of<AppState>(context, listen: false);
      
      await appState.initialize();
      logger.d(appState.userState.get().toJson());
      logger.d(appState.settingsState.get().toJson());
      //await Future.delayed(Duration(seconds: 2));
      
      // Navigate to HomePage
      if(context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
      
    } catch (error) {
      // Handle errors (e.g., navigate to login screen or show error)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
