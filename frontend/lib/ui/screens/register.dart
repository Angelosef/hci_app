import 'package:flutter/material.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/app_state.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/custom_input_field.dart'; // Import your CustomInputField
import 'package:logger/logger.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final Logger logger = Logger(level: Level.debug);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = context.select<AppState, UserProvider>((state) => state.userState);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00344C), // App bar background color
      ),
      body: Container(
        color: const Color(0xFF00344C), // Page background color
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Centered Username Input using CustomInputField with width constraint
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75, // 75% of screen width
                  child: CustomInputField(
                    hintText: "Username",
                    controller: _usernameController,
                  ),
                ),
              ),
              const SizedBox(height: 30), // Space between input fields
              // Centered Password Input using CustomInputField with width constraint
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75, // 75% of screen width
                  child: CustomInputField(
                    hintText: "Password",
                    isPassword: true,
                    controller: _passwordController,
                  ),
                ),
              ),
              const SizedBox(height: 50), // Space before the button
              // Sign Up Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF37637F), // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0), // Rounded button
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    logger.d(username);
                    logger.d(password);

                    // Call registration service
                    try {
                      final AuthService authService = AuthService();
                      final user = await authService.register(username, password);
                      logger.d(user.toJson());
                      userProvider.set(user); // Save user state
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, '/loading'); // Navigate to Home/Loading
                      }
                    } catch (error) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Sign up failed: ${error.toString()}")),
                        );
                      }
                    }
                  }
                },
                child: const Text("Sign Up"),
              ),
              const SizedBox(height: 100), // Space before the login prompt
              // Already have an account message
              const Text(
                "Already have an account?",
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 10), // Space before the Log In button
              // Log In Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF37637F), // Match button color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0), // Rounded button
                  ),
                ),
                onPressed: () {
                  logger.d('Log in button pressed');
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text("Log In"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF00293D), // Bottom bar color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // Go back action
              },
            ),
          ],
        ),
      ),
    );
  }
}
