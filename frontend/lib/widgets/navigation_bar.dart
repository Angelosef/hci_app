import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTabSelected;

  const NavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabSelected,
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
              icon: Icon(
                Icons.map,
                color: currentIndex == 0 ? Colors.white : const Color(0xFF006878),
              ),
              onPressed: () => onTabSelected?.call(0),
            ),
            IconButton(
              icon: Icon(
                Icons.list,
                color: currentIndex == 1 ? Colors.white : const Color(0xFF006878),
              ),
              onPressed: () => onTabSelected?.call(1),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: currentIndex == 2 ? Colors.white : const Color(0xFF006878),
              ),
              onPressed: () => onTabSelected?.call(2),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: currentIndex == 3 ? Colors.white : const Color(0xFF006878),
              ),
              onPressed: () => onTabSelected?.call(3),
            ),
            IconButton(
              icon: Icon(
                Icons.camera_alt,
                color: currentIndex == 4 ? Colors.white : const Color(0xFF006878),
              ),
              onPressed: () => onTabSelected?.call(4),
            ),
          ],
        ),
      ),
    );
  }
}
