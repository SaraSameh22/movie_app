class Movie {
  final String title;
  final String imageUrl;
  final double rating;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      imageUrl: json['image'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}