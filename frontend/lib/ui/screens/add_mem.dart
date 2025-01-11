import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // You'll need to add the image_picker package
import 'dart:io';  // Add this import to use the File class
import 'package:frontend/widgets/navigation_bar.dart';

class AddMemoryScreen extends StatefulWidget {
  const AddMemoryScreen({super.key});

  @override
  _AddMemoryScreenState createState() => _AddMemoryScreenState();
}

class _AddMemoryScreenState extends State<AddMemoryScreen> {
  XFile? _image; // To hold the selected image
  final TextEditingController _titleController = TextEditingController(); // Controller for the title
  final TextEditingController _descriptionController = TextEditingController(); // Controller for the description

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;
    double topBarHeight = kToolbarHeight; // Height of the app bar (default is 56.0)
    double bottomBarHeight = kBottomNavigationBarHeight; // Bottom bar height

    // Image size (25% larger than before)
    double imageSize = 125; // Image square size (was 100, now 125)

    // Calculate available height for description input area
    double descriptionAreaHeight = screenHeight - topBarHeight - imageSize - bottomBarHeight - 60; // 20px margin above the bottom bar

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00293D), // Top bar color
        elevation: 0, // Remove shadow
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notifications action
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            // Handle settings action
          },
        ),
      ),
      body: Stack(
        children: [
          // Add a placeholder for the picture selection (25% larger)
          Positioned(
            top: 15,
            left: 15,
            child: GestureDetector(
              onTap: _pickImage, // Open the image picker when tapped
              child: Container(
                width: imageSize, // 25% larger (was 100)
                height: imageSize, // 25% larger (was 100)
                decoration: BoxDecoration(
                  color: const Color(0xFF00344C), // Square background color
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  border: Border.all(color: Colors.white, width: 2), // Border to indicate the picture area
                ),
                child: _image == null
                    ? const Icon(Icons.add_a_photo, color: Colors.white) // Icon if no image selected
                    : Image.file(
                        File(_image!.path),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),

          // Add the image picker bottom sheet here when the user presses the square
          if (_image == null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: const Color(0xFF00344C),
                height: MediaQuery.of(context).size.height * 0.5, // Half screen for the picker
                child: Column(
                  children: [
                    TextButton(
                      onPressed: _pickImage, // Open gallery to select image
                      child: const Text(
                        "Select Image from Gallery",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Title Input Field next to the photo (with dynamic height)
          Positioned(
            top: 15,
            left: imageSize + 20, // Positioning it next to the image
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF00344C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00344C), width: 2),
              ),
              height: 125, // Set dynamic height
              child: SingleChildScrollView( // Allow scrolling if text overflows
                scrollDirection: Axis.vertical, // Scroll vertically when necessary
                child: TextField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white, fontSize: 22), // Larger font size for title
                  maxLines: null, // Allow the title to wrap to the next line
                  decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text, // Open the keyboard for text input
                ),
              ),
            ),
          ),

          // Description Input Field below the title (with dynamic height)
          Positioned(
            top: imageSize + 20, // Just below the image (with a 20px margin)
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF00344C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00344C), width: 2),
              ),
              height: descriptionAreaHeight, // Set dynamic height
              child: SingleChildScrollView( // Allow scrolling if text overflows
                scrollDirection: Axis.vertical, // Scroll vertically when necessary
                child: TextField(
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: null, // Make the TextField expand vertically
                  decoration: const InputDecoration(
                    hintText: "Add a description",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text, // Open the keyboard for text input
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(), // Replace BottomAppBar with your custom NavigationBar widget
      backgroundColor: const Color(0xFF00344C), // Screen background color
    );
  }
}
