import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/Model/search_response.dart';
import 'dart:convert';
import 'package:movies/api_manager.dart';
import 'package:movies/movie_card.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String query = "";
  Future<SearchResponse>? searchResults;

  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<dynamic> _movies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Search"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onSubmitted: ApiManager.searchMovies,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: ImageIcon(AssetImage('assets/images/search.png'), color: Colors.white),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
          onChanged: (text) {
            setState(() {
              query = text;
              searchResults = ApiManager.searchMovies(query);
            });
          },
        ),
            const SizedBox(height: 16),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            if (!_isLoading && _movies.isEmpty)
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/empty.png',
                    width: 124,
                    height: 124,
                  ),
                ),
              )
            else if (!_isLoading)
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    final movie = _movies[index];
                    return MovieCard(
                      title: movie['title'] ?? "Unknown Title",
                      imagePath: movie['poster_path'] != null
                          ? "https://image.tmdb.org/t/p/w500${movie['poster_path']}"
                          : "assets/images/empty.png", // Fallback image
                      // rating: movie['rating']?.toString() ?? "N/A",
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}


