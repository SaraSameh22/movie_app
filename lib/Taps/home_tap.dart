import 'package:flutter/material.dart';
import 'package:movies/Model/movie_response_home.dart';
import 'package:movies/Model/upcoming_response.dart';
import 'package:movies/api_manager.dart';
import 'package:movies/movie_card.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  // final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset("assets/images/Available.png"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 250,
                child: FutureBuilder<popularResponse>(
                  future: ApiManager.getPopular(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final movies = snapshot.data?.results ?? [];
                    if (movies.isEmpty) {
                      return const Center(child: Text("No upcoming movies"));
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return MovieCard(
                          title: movie.title ?? "",
                          imagePath:
                              "https://image.tmdb.org/t/p/original/${movie.posterPath ?? ''}",
                          rating: movie.voteAverage ?? 0,
                          movieId: movies[index].id!,
                        );
                      },
                    );
                  },
                ),
              ),
              Center(
                  child: Image.asset(
                "assets/images/Watch.png",
              )),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    " Action ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Text(
                    " see More ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(0XFFF6BD00),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 250,
                child: FutureBuilder<upcomingResponse>(
                  future: ApiManager.getUpcoming(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final movies = snapshot.data?.results ?? [];
                    if (movies.isEmpty) {
                      return const Center(child: Text("No upcoming movies"));
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return MovieCard(
                          title: movie.title ?? "",
                          imagePath:
                              "https://image.tmdb.org/t/p/original/${movie.posterPath ?? ''}",
                          rating: movie.voteAverage ?? 0,
                          movieId: movies[index].id!,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
