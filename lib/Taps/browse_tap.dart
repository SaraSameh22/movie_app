import 'package:flutter/material.dart';
import 'package:movies/Model/categories_response.dart';
import 'package:movies/Model/movie_browse_response.dart';
import 'package:movies/api_manager.dart';
import 'package:movies/movie_card.dart';

class BrowseTap extends StatefulWidget {
  const BrowseTap({super.key});

  @override
  State<BrowseTap> createState() => _BrowseTapState();
}

class _BrowseTapState extends State<BrowseTap> {
  // late  Future<movieResponse> movies ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<categoriesResponse>(
        future: ApiManager.getCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData) {
            print("Data: ${snapshot.data}");
            return const Center(
                child: Text("No data found",
                    style: TextStyle(color: Colors.white)));
          }
          var data = snapshot.data!.genres!;
          return DefaultTabController(
            length: data.length,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: TabBar(
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.black,
                    unselectedLabelColor: const Color(0XFFF6BD00),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    indicator: BoxDecoration(
                        color: const Color(0XFFF6BD00),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black, width: 2)),
                    tabs: data
                        .map((source) => Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0XFFF6BD00), width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Tab(text: source.name),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: data.map((source) {
                      return FutureBuilder<movieResponse>(
                        future: ApiManager.getMovies(genreId: source.id),
                        builder: (context, snapshot) {
                          // print("FutureBuilder Triggered: ${snapshot.connectionState}");
                          // print("Has Data: ${snapshot.hasData}");
                          // print("Error: ${snapshot.error}");

                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                "Error: ${snapshot.error}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          final movies = snapshot.data!.results;
                          // print("Movies Retrieved: $movies");
                          if (movies == null || movies.isEmpty) {
                            return const Center(
                                child: Text("No movies available"));
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
                              return MovieCard(
                                title: movies[index].title!,
                                imagePath: movies[index].posterPath!,
                                rating: movies[index].voteAverage!,
                                movieId: movies[index].id!,
                              );
                            },
                          );
                        },

                        // ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
