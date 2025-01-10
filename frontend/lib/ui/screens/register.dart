import 'package:flutter/material.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/app_state.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:logger/logger.dart';

// Register Screen
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final Logger logger = Logger(level: Level.debug);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = context.select<AppState, UserProvider>((state)=>state.userState);

    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Username Input
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your username";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Password Input
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              // Login Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    logger.d(username);
                    logger.d(password);

                    // Call login service
                    try {
                      final AuthService authService = AuthService();
                      final user = await authService.register(
                          username, password);
                      logger.d(user.toJson());
                      userProvider.set(user); // Save user state
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, '/loading'); // Navigate to Home
                      }
                    } catch (error) {
                      if (context.mounted) {
                        // Check if the widget is still mounted
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Sign up failed: ${error.toString()}")),
                        );
                      }
                    }
                  }
                },
                child: Text("Sign Up"),
              ),
              SizedBox(height: 50),
              Text("Changed your mind? Log in!"),
              ElevatedButton(
                onPressed: () {
                  logger.d('log in button pressed');
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text("Log In")
                ),
            ],
          ),
        ),
      ),
    );
  }
}