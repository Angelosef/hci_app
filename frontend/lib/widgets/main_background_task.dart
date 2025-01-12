import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/clue_provider.dart';
import 'package:frontend/providers/user_provider.dart';


class MainBackgroundTask extends StatefulWidget {
  const MainBackgroundTask({Key? key}) : super(key: key);

  @override
  _MainBackgroundTaskState createState() => _MainBackgroundTaskState();
}

class _MainBackgroundTaskState extends State<MainBackgroundTask> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startLocationCheck();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLocationCheck() {
    final clueProvider = Provider.of<ClueProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    _timer = Timer.periodic(const Duration(seconds: 60), (_) async {
      try {
        final user = userProvider.get(); // Retrieve the user using the `get()` method
        final userId = user.id; // Access the user's ID
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        await clueProvider.checkForUnlocks(userId, position);
      } catch (e) {
        debugPrint('Error during location check: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
