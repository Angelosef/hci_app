import 'package:flutter/material.dart';
import 'package:frontend/ui/screens/camera_ar.dart';
import 'package:frontend/ui/screens/clues.dart';
import 'package:frontend/ui/screens/loading.dart';
import 'package:frontend/ui/screens/login.dart';
import 'package:frontend/ui/screens/add_mem.dart';
import 'package:frontend/ui/screens/memories.dart';
import 'package:frontend/ui/screens/register.dart';
import 'package:frontend/ui/screens/settings.dart';
import 'package:frontend/ui/screens/home.dart';
import 'package:frontend/ui/screens/clue_display.dart';


import 'package:provider/provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/providers/memory_provider.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/providers/clue_provider.dart';




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HCI App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define named routes
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/loading': (context) => LoadingScreen(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterScreen(),
        '/home/settings': (context) => SettingsScreen(),
        '/home/clues': (context) => CluesList(),
        '/home/add_mem': (context) => AddMemoryScreen(),
        '/home/camera': (context) => CameraARScreen(),
      },
    );
  }
}

void testLogin() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MemoryProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => ClueProvider()),
      ],
      child: MyApp(),
    ),
  );
}
