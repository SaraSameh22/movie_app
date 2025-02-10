import 'package:flutter/material.dart';
import 'package:movies/Model/categories_response.dart';
import 'package:movies/api_manager.dart';
// import 'package:movies/movie_card.dart';

class BrowseTap extends StatelessWidget {
  // late  Future<movieResponse> movies ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Movies"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<categoriesResponse>(
        future: ApiManager.getCategory(),
        builder:(context , snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
           } else if (snapshot.hasError) {
    return Center(child: Text("Error: ${snapshot.error}", style: TextStyle(color: Colors.white)));
    } else if (!snapshot.hasData) {
            print("Data: ${snapshot.data}");
      return Center(child: Text("No data found", style: TextStyle(color: Colors.white)));
    }
          var data = snapshot.data!.genres!;
          return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  data[index].name ?? "",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 25),
            itemCount: data.length,
          );
        },
      ),

      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: FutureBuilder<movieResponse>(
      //     future: movies,
      //     builder: (BuildContext context, AsyncSnapshot<movieResponse> snapshot) {
      //       if (!snapshot.hasData) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       final movies = snapshot.data?.results!;
      //       if (movies!.isEmpty) {
      //         return const Center(child: Text("No popular movies"));
      //       }
      //
      //       return GridView.builder(
      //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 2,
      //           crossAxisSpacing: 10,
      //           mainAxisSpacing: 10,
      //           childAspectRatio: 2 / 3,
      //         ),
      //         itemCount: movies!.length,
      //         itemBuilder: (context, index) {
      //           return MovieCard(
      //             title: movies[index].title!,
      //             imagePath: movies[index].posterPath!,
      //             // rating: movies[index].voteAverage!.toString(),
      //           );
      //         },
      //       );
      //     },
      //
      //   ),
      // ),
    );
  }
}



















