import 'package:flutter/material.dart';
import 'package:frontend/ui/screens/loading.dart';
import 'package:frontend/ui/screens/login.dart';
import 'package:frontend/ui/screens/add_mem.dart';
import 'package:frontend/ui/screens/register.dart';
import 'package:frontend/ui/screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/app_state.dart';
import 'package:logger/logger.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Logger logger = Logger(level: Level.debug);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        children: [
          Center(
            child: Text("You are logged in!"),
          ),
          ElevatedButton(onPressed: () {
            logger.d('clicked to go to settings');
            Navigator.pushNamed(context, '/home/settings');
          }
          , child: 
          Text('Settings')
          ),
        ],
      ),
    );
  }
}

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
        '/': (context) => AddMemoryScreen(),
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
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MyApp(),
    ),
  );
}
