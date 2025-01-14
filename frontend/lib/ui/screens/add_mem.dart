import 'package:flutter/material.dart';
import 'package:frontend/providers/memory_provider.dart';
import 'package:image_picker/image_picker.dart'; // For selecting images
import 'dart:io'; // For the File class
import 'package:frontend/services/memory_service.dart'; // Import the memory service
import 'package:frontend/providers/user_provider.dart'; // Import the UserProvider
import 'package:provider/provider.dart'; // Import provider package
import 'package:logger/logger.dart';
import 'package:geolocator/geolocator.dart'; // Import Geolocator package for location

class AddMemoryScreen extends StatefulWidget {
  const AddMemoryScreen({super.key});

  @override
  _AddMemoryScreenState createState() => _AddMemoryScreenState();
}

class _AddMemoryScreenState extends State<AddMemoryScreen> {
  XFile? _image; // Holds the selected image
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Logger logger = Logger(level: Level.debug);
  double? _latitude; // To store latitude
  double? _longitude; // To store longitude

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch current location when screen is initialized
  }

  // Method to get the user's current location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    } catch (e) {
      logger.e("Error getting location: $e");
    }
  }

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill in both title and description.'),
      ));
      return;
    }

    // Ensure location is available
    if (_latitude == null || _longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location is not available. Please try again.'),
      ));
      return;
    }

    // Get the current user from UserProvider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final memoryProvider = Provider.of<MemoryProvider>(context, listen: false);
    int userId = userProvider.get().id; // Get user ID from the provider
    String imagePath = _image?.path ?? ''; // Get image path

    final memoryService = MemoryService();
    final result = await memoryService.addMemory(
      userId: userId,
      title: title,
      content: description,
      imagePath: imagePath,
      latitude: _latitude!,  // Include latitude
      longitude: _longitude!, // Include longitude
    );

    if (result['success']) {
      memoryProvider.initialize(userId);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Memory added successfully!'),
      ));
      //Navigator.pop(context); // Navigate back to the previous screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to add memory. Please try again!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topBarHeight = kToolbarHeight;
    double imageSize = 125;
    double descriptionAreaHeight = screenHeight - topBarHeight - imageSize - 60;

    return Scaffold(
      // Remove the appBar to remove the top bar
      body: Stack(
        children: [
          Positioned(
            top: 15,
            left: 15,
            child: GestureDetector(
              onTap: _pickImage,
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
              child: TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white, fontSize: 22),
                decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
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
              child: TextField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Add a description",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
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
      backgroundColor: const Color(0xFF00344C),
    );
  }
}
