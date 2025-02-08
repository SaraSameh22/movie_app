import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String imagePath;
  // final String rating;

  const MovieCard({
    required this.title,
    required this.imagePath,
    // required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.white),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  // Text(
                  //   rating,
                  //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  // ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
