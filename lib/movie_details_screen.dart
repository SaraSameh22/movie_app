import 'package:flutter/material.dart';
import 'package:movies/Model/cast_response.dart';
import 'package:movies/Model/movie_details_response.dart';
import 'package:movies/Model/screenshot_response.dart';
import 'package:movies/Model/similar_response.dart';
import 'package:movies/api_manager.dart';
import 'package:movies/movie_card.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<movieDetailsResponse>(
        future: ApiManager.getMovieDetails(widget.movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Failed to load movie details ${snapshot.error.toString()}");
            return Center(
                child: Text(
                    'Failed to load movie details ${snapshot.error.toString()}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          final movieData = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      ClipRect(
                          child: Image.network(
                        "https://image.tmdb.org/t/p/original/${movieData.posterPath ?? ''}",
                        height: 645,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
                      Container(
                        child: Image.asset("assets/images/play.png"),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        child: Column(children: [
                          Text(
                            movieData.title ?? "",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            movieData.releaseDate!.substring(0, 4) ?? "",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ]),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 12),
                            ),
                            child: Text(
                              'Watch Now',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0XFF282A28),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              ImageIcon(AssetImage('assets/images/like.png'),
                                  color: Color(0XFFFFBB3B)),
                              SizedBox(width: 10),
                              Text(
                                '${movieData.voteAverage}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0XFF282A28),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              ImageIcon(AssetImage('assets/images/runtime.png'),
                                  color: Color(0XFFFFBB3B)),
                              SizedBox(width: 10),
                              Text(
                                '${movieData.runtime}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0XFF282A28),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              ImageIcon(AssetImage('assets/images/rate.png'),
                                  color: Color(0XFFFFBB3B)),
                              SizedBox(width: 10),
                              Text(
                                '${movieData.voteAverage}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('Screen Shots',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
                FutureBuilder<screenshotResponse>(
                  future: ApiManager.getScreenShots(widget.movieId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasError)
                      return _errorText(snapshot.error.toString());

                    final screenshots = snapshot.data!.backdrops ?? [];
                    if (screenshots.isEmpty)
                      return _errorText("No Cast available");

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: screenshots.take(3).map((cast) {
                          if (cast.filePath == null || cast.filePath!.isEmpty) {
                            return SizedBox.shrink();
                          }
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w200/${cast.filePath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                Text('Similar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
                SizedBox(height: 8),
                FutureBuilder<similarResponse>(
                  future: ApiManager.getSimilarMovies(widget.movieId),
                  builder: (context, snapshot) {
                    print(
                        "FutureBuilder Triggered: ${snapshot.connectionState}");
                    print("Has Data: ${snapshot.hasData}");
                    print("Error: ${snapshot.error}");

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    if (!snapshot.hasData ||
                        snapshot.data!.results == null ||
                        snapshot.data!.results!.isEmpty) {
                      return Center(
                          child: Text("No similar movies available",
                              style: TextStyle(color: Colors.white)));
                    }

                    final movies = snapshot.data!.results;
                    print("Movies Retrieved: $movies");
                    if (movies == null || movies.isEmpty) {
                      return const Center(child: Text("No movies available"));
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child:
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2 / 3,
                        ),
                        itemCount: movies.where((movie) =>
                        movie.title != null &&
                            movie.posterPath != null &&
                            movie.voteAverage != null &&
                            movie.id != null
                        ).take(4).length, // Ensures only valid movies are counted
                        itemBuilder: (context, index) {
                          final filteredMovies = movies.where((movie) =>
                          movie.title != null &&
                              movie.posterPath != null &&
                              movie.voteAverage != null &&
                              movie.id != null
                          ).toList(); // Converts filtered results to a list

                          return MovieCard(
                            title: filteredMovies[index].title!,
                            imagePath: filteredMovies[index].posterPath!,
                            rating: filteredMovies[index].voteAverage!,
                            movieId: filteredMovies[index].id!,
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                Text('Summary',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
                SizedBox(height: 16),
                Text(movieData.overview ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16)),
                SizedBox(height: 16),
                Text('Cast',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
                SizedBox(height: 16),
                FutureBuilder<castResponse>(
                  future: ApiManager.getMovieCast(widget.movieId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasError)
                      return _errorText(snapshot.error.toString());

                    final castList = snapshot.data!.cast ?? [];
                    if (castList.isEmpty)
                      return _errorText("No Cast available");

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: castList
                            .take(6)
                            .map((cast) {
                          if (cast.profilePath == null ||
                              cast.profilePath!.isEmpty) {
                            return SizedBox.shrink();
                          }
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0XFF282A28),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w200/${cast.profilePath}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: ${cast.name}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Character: ${cast.character}",
                                        style:
                                            TextStyle(color: Colors.grey[400]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                Text('Genres',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: movieData.genres?.map((genre) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Color(0XFF282A28),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  genre.name!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _errorText(String error) =>
      Center(child: Text(error, style: TextStyle(color: Colors.white)));
}
