import 'package:flutter/material.dart';

class Movie {
  final int id;
  final String title;
  final String imagePath;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.rating,
  });
}




class HistoryManager with ChangeNotifier {
  final List<Movie> _history = [];

  List<Movie> get history => List.unmodifiable(_history);

  void addToHistory(Movie movie) {
    if (!_history.any((m) => m.id == movie.id)) {
      _history.add(movie);
      notifyListeners();
    }
  }
}
