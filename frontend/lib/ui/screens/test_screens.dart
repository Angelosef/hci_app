import 'package:flutter/material.dart';
import 'package:frontend/ui/screens/loading.dart';
import 'package:frontend/ui/screens/login.dart';
import 'package:frontend/ui/screens/register.dart';
import 'package:frontend/ui/screens/settings.dart';
import 'package:frontend/ui/screens/home.dart';

import 'package:provider/provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/providers/memory_provider.dart';
import 'package:frontend/providers/settings_provider.dart';



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
      ],
      child: MyApp(),
    ),
  );
}
