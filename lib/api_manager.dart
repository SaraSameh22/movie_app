import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/Model/categories_response.dart';
import 'package:movies/Model/search_response.dart';

import 'Model/movie_response_home.dart';

class ApiManager {

  static Future<categoriesResponse> getCategory() async {
    Uri url = Uri.https("api.themoviedb.org", "/3/genre/movie/list",);
    try {
      final response = await http.get(url,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw",
        },
      );
      if (response.statusCode == 200) {
        print("Response: ${response.body}");
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }
    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);
    categoriesResponse category = categoriesResponse.fromJson(json);
    return category;
  }


  static Future<movieResponse> getMovies() async {
    Uri url = Uri.https("api.themoviedb.org", "/3/discover/movie",);
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw",
        },
      );

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);

    movieResponse movies = movieResponse.fromJson(json);
    return movies;
  }


  static Future<SearchResponse> searchMovies(String query) async {
    if (query.isEmpty) {
      return SearchResponse( results: []);
    }
    Uri url = Uri.https("api.themoviedb.org", "/3/search/movie", {
      "query": query,
    });
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw"
        },
      );

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);

    SearchResponse searchRes = SearchResponse.fromJson(json);
    return searchRes;
  }


  static Future<popularResponse> getPopular() async {
    Uri url = Uri.https("api.themoviedb.org", "/3/movie/popular",);
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw",
          // Replace with your API key
        },
      );

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);

    popularResponse popular = popularResponse.fromJson(json);
    return popular;
  }
}
