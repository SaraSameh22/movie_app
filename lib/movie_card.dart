import 'package:flutter/material.dart';
import 'package:movies/movie_details_screen.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double rating;
  final int movieId;

  const MovieCard({
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.movieId
  });

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap:  () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(movieId: movieId),
            ),
          );
        },
        child: Stack(
        children: [
          Container(
            width: 180,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(
                  "https://image.tmdb.org/t/p/original/${imagePath ?? ''}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      "${rating.toStringAsFixed(1)}",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
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
