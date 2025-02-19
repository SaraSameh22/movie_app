import 'package:flutter/material.dart';
import 'package:movies/Model/search_response.dart';
import 'package:movies/api_manager.dart';
import 'package:movies/movie_card.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String query = "";
  Future<SearchResponse>? searchResults;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const ImageIcon(AssetImage('assets/images/search.png'),
                    color: Colors.white),
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
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 250,
                  child: FutureBuilder<SearchResponse>(
                      future: ApiManager.searchMovies(query),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final movies = snapshot.data?.results ?? [];
                        if (movies.isEmpty) {
                          return Center(
                              child: Image.asset("assets/images/empty.png"));
                        }

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2 / 3,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return MovieCard(
                              title: movie.title ?? "Unknown Title",
                              imagePath: movie.posterPath != null
                                  ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                                  : "assets/images/empty.png", // Fallback image
                              rating: movie.voteAverage!,
                              movieId: movies[index].id!,
                            );
                          },
                        );
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
