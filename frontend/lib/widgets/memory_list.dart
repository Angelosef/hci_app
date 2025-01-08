import 'package:flutter/material.dart';
import '../models/memory.dart';

class MemoryList extends StatelessWidget {
  final List<Memory> memories;

  MemoryList({required this.memories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: memories.length,
      itemBuilder: (context, index) {
        return MemoryListItem(memory: memories[index]);
      },
    );
  }
}

class MemoryListItem extends StatelessWidget {
  final Memory memory;

  MemoryListItem({required this.memory});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      height: 133,
      decoration: BoxDecoration(
        color: Color(0xFF37637F), // Hex color for the rectangle
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Memory Image
          Container(
            margin: EdgeInsets.all(9), // Gap inside the rectangle
            width: 115,
            height: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: memory.imageUrl.isNotEmpty
                    ? NetworkImage(memory.imageUrl)
                    : AssetImage('assets/placeholder.jpg') as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Memory Title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  memory.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
