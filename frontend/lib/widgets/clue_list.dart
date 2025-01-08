import 'package:flutter/material.dart';
import '../models/clue.dart';

class ClueList extends StatelessWidget {
  final List<Clue> clues;

  const ClueList({Key? key, required this.clues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clues.length,
      itemBuilder: (context, index) {
        final clue = clues[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: Container(
            height: 133,
            decoration: BoxDecoration(
              color: const Color(0xFF6B538C),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                // Image section
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    width: 115,
                    height: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: clue.imageUrl.isNotEmpty
                            ? NetworkImage(clue.imageUrl)
                            : const AssetImage('assets/placeholder.jpg')
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          clue.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
