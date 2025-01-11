import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final void Function()? onMapPressed;
  final void Function()? onListPressed;
  final void Function()? onAddPressed;
  final void Function()? onFlagPressed;
  final void Function()? onCameraPressed;

  const NavBar({
    Key? key,
    this.onMapPressed,
    this.onListPressed,
    this.onAddPressed,
    this.onFlagPressed,
    this.onCameraPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF00293D), // Bottom bar color
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.map, color: Color(0xFF006878)), // Non-selected icon
              onPressed: onMapPressed, // Callback for map action
            ),
            IconButton(
              icon: const Icon(Icons.list, color: Color(0xFF006878)), // Non-selected icon
              onPressed: onListPressed, // Callback for list action
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white), // Selected icon
              onPressed: onAddPressed, // Callback for add action
            ),
            IconButton(
              icon: const Icon(Icons.flag, color: Color(0xFF006878)), // Non-selected icon
              onPressed: onFlagPressed, // Callback for flag action
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Color(0xFF006878)), // Non-selected icon
              onPressed: onCameraPressed, // Callback for camera action
            ),
          ],
        ),
      ),
    );
  }
}
