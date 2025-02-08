import 'package:flutter/material.dart';
import 'package:movies/Model/movie_response_home.dart';
import 'package:movies/api_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
   // late  Future<popularResponse> popularMovies;
  final PageController _controller = PageController();

  @override
  void initState() {
    // popularMovies = ApiManager.getPopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
        leading: const Icon(Icons.menu),
        centerTitle: true,
        actions: const [
          Icon(Icons.search_rounded),
          SizedBox(width: 20),
          Icon(Icons.notifications),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "  Now Showing",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<popularResponse>(
                future: ApiManager.getPopular(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                   final movies = snapshot.data?.results??[] ;
                  if (movies.isEmpty) {
                    return const Center(child: Text("No movies available"));
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: 250,
                        child: PageView.builder(
                          controller: _controller,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://image.tmdb.org/t/p/original/${movie.posterPath ?? ''}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 15,
                                  left: 0,
                                  right: 0,
                                  child: Text(
                                    movie.voteAverage?.toString() ?? "N/A",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: movies.length,
                        effect: const WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 4,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blue,
                        ),
                      ),
                    ],
                  );
                },
              ),
            const SizedBox(height: 20),
              const Text(
                "  Up Coming Movies",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 250,
                child: FutureBuilder<popularResponse>(
                  future:ApiManager.getPopular(),
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
                        return Stack(
                          children: [
                            Container(
                              width: 180,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://image.tmdb.org/t/p/original/${movie.posterPath ?? ''}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 0,
                              right: 0,
                              child: Text(
                                movie.voteAverage?.toString() ?? "N/A",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "  Popular Movies",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black,
                ),
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
                      return const Center(child: Text("No popular movies"));
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Stack(
                          children: [
                            Container(
                              width: 180,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://image.tmdb.org/t/p/original/${movie.posterPath?? ''}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 0,
                              right: 0,
                              child: Text(
                                movie.voteAverage?.toString() ?? "N/A",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
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

