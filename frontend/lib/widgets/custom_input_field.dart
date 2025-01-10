import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText; // Placeholder text
  final bool isPassword;
  final TextEditingController controller;

  const CustomInputField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey), // Placeholder style
        filled: true,
        fillColor: const Color(0xFFE5E2E1), // Background color
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0), // Padding inside the field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
          borderSide: BorderSide.none, // No border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.blue), // Optional border when focused
        ),
      ),
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $hintText";
        }
        return null;
      },
    );
  }
}
