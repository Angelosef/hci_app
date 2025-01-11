import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // You'll need to add the image_picker package
import 'dart:io';  // Add this import to use the File class
import 'package:frontend/services/memory_service.dart'; // Import the memory service
import 'package:frontend/widgets/navigation_bar.dart'; // Assuming you have a navigation bar widget

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

  Future<void> _saveMemory() async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in both title and description.'),
      ));
      return;
    }

    int userId = 1; // Example user ID, use the actual user ID here
    String imagePath = _image?.path ?? ''; // If no image, pass an empty string

    final memoryService = MemoryService();
    final result = await memoryService.addMemory(
      userId: userId,
      title: title,
      content: description,
      imagePath: imagePath,
    );

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Memory added successfully!'),
      ));
      Navigator.pop(context); // Go back to the previous screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add memory. Please try again!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topBarHeight = kToolbarHeight;
    double bottomBarHeight = kBottomNavigationBarHeight;
    double imageSize = 125;
    double descriptionAreaHeight = screenHeight - topBarHeight - imageSize - bottomBarHeight - 60;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00293D),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Add a placeholder for the picture selection
          Positioned(
            top: 15,
            left: 15,
            child: GestureDetector(
              onTap: _pickImage, // Open the image picker when tapped
              child: Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  color: const Color(0xFF00344C),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: _image == null
                    ? const Icon(Icons.add_a_photo, color: Colors.white)
                    : Image.file(File(_image!.path), fit: BoxFit.cover),
              ),
            ),
          ),

          // Add the image picker bottom sheet if no image is selected
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

          // Title Input Field next to the photo
          Positioned(
            top: 15,
            left: imageSize + 20,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF00344C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00344C), width: 2),
              ),
              height: 125,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: TextField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ),

          // Description Input Field below the title
          Positioned(
            top: imageSize + 20,
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF00344C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00344C), width: 2),
              ),
              height: descriptionAreaHeight,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: TextField(
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Add a description",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ),

          // Save Memory Button at the bottom
          Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: ElevatedButton(
              onPressed: _saveMemory,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006878),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Save Memory',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(), // Custom navigation bar
      backgroundColor: const Color(0xFF00344C),
    );
  }
}
