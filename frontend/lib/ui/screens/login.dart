import 'package:flutter/material.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/app_state.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/custom_input_field.dart'; // Import the custom input field
import 'package:logger/logger.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final Logger logger = Logger(level: Level.debug);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = context.select<AppState, UserProvider>((state)=>state.userState);

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
              const SizedBox(height: 30), // Increased space between fields
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
              // Login Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF37637F), // Match input field color
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

                    // Call login service
                    try {
                      final AuthService authService = AuthService();
                      final user = await authService.login(
                          username, password); // Your login service function
                      logger.d(user.toJson());
                      userProvider.set(user); // Save user state
                       if(context.mounted) {
                        Navigator.pushReplacementNamed(context, '/loading'); // Navigate to Home
                      }// Navigate to Home
                      // Navigator.pushReplacementNamed(context, '/home');
                    } catch (error) {
                      if (context.mounted) {
                        // Check if the widget is still mounted
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Login failed: ${error.toString()}")),
                        );
                      }
                    }
                  }
                },
                child: const Text("Log In"),
              ),
              const SizedBox(height: 100), // Space before message
              // Don't have an account message
              Text(
                "Don't have an account?",
                style: const TextStyle(
                  color: Colors.white, // White color for text
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 10), // Space before Sign Up button
              // Sign Up Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF37637F), // Match input field color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0), // Rounded button
                  ),
                ),
                onPressed: () {
                  // Add your sign up action here, such as navigating to the sign up screen
                  // Navigator.pushNamed(context, '/sign_up'); // Example navigation
                },
                child: const Text("Sign Up"),
              ),
              SizedBox(height: 50),
              Text("Don't have an account? Sign up!"),
              ElevatedButton(
                onPressed: () {
                  logger.d('sign up button pressed');
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text("Sign Up")
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF00293D),
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
