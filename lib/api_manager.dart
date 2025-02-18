import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/Model/cast_response.dart';
import 'package:movies/Model/categories_response.dart';
import 'package:movies/Model/movie_browse_response.dart';
import 'package:movies/Model/movie_details_response.dart';
import 'package:movies/Model/screenshot_response.dart';
import 'package:movies/Model/search_response.dart';
import 'package:movies/Model/similar_response.dart';
import 'package:movies/Model/upcoming_response.dart';

import 'Model/movie_response_home.dart';

class ApiManager {

  static Future<categoriesResponse> getCategory() async {
    Uri url = Uri.parse("https://api.themoviedb.org/3/genre/movie/list?api_key=7844ed77e021c66cba973afe4f77066d");
    try {
      final response = await http.get(url,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw",
        },
      );
      if (response.statusCode == 200) {
        // print("Category Response: ${response.body}");
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

  static Future<movieResponse> getMovies({int? genreId}) async {
    Uri url = Uri.parse("https://api.themoviedb.org/3/discover/movie?with_genres=$genreId&api_key=7844ed77e021c66cba973afe4f77066d");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw",
        },
      );

      if (response.statusCode == 200) {
        // print("Response of movies from genres: ${response.body} ");
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
    Uri url = Uri.https("api.themoviedb.org", "/3/search/movie", {
      "api_key": "7844ed77e021c66cba973afe4f77066d",
      "query": query,
    });    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw"
        },
      );

      if (response.statusCode == 200) {
        // print(" Search Response: ${response.body} ");
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
    Uri url = Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=7844ed77e021c66cba973afe4f77066d");
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw",
        },
      );

      if (response.statusCode == 200) {
        // print("Popular Response: ${response.body}");
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

  static Future<upcomingResponse> getUpcoming() async {
    Uri url = Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=7844ed77e021c66cba973afe4f77066d");
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw",
        },
      );

      if (response.statusCode == 200) {
        // print("Upcoming Response: ${response.body} ");
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);

    upcomingResponse upcoming = upcomingResponse.fromJson(json);
    return upcoming;
  }

  static Future<movieDetailsResponse> getMovieDetails(int movieId) async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId?api_key=7844ed77e021c66cba973afe4f77066d");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw"
        },
      );

      if (response.statusCode == 200) {
        // print("Movie Details Response: ${response.body}");
        return movieDetailsResponse.fromJson(json.decode(response.body));
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
        throw Exception("Failed to load movie details");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("Failed to fetch movie details: $e");
    }
  }

  static Future<similarResponse> getSimilarMovies(int movieId) async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId/similar?api_key=7844ed77e021c66cba973afe4f77066d");
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw"
        },
      );

      if (response.statusCode == 200) {
        // print("Similar Movies Response: ${response.body} ");
        return similarResponse.fromJson(json.decode(response.body));
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
        throw Exception("Failed to load movie details");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("Failed to fetch movie details: $e");
    }
  }

  static Future<castResponse> getMovieCast(int movieId) async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=7844ed77e021c66cba973afe4f77066d");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw"
        },
      );

      if (response.statusCode == 200) {
        // print("Movie Cast Response: ${response.body}");
        return castResponse.fromJson(json.decode(response.body));
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
        throw Exception("Failed to load movie details");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("Failed to fetch movie details: $e");
    }
  }

  static Future<screenshotResponse> getScreenShots(int movieId) async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId/images?api_key=7844ed77e021c66cba973afe4f77066d");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODQ0ZWQ3N2UwMjFjNjZjYmE5NzNhZmU0Zjc3MDY2ZCIsIm5iZiI6MTczODY4NjkxOS4zODQsInN1YiI6IjY3YTI0MWM3ZWVhODlhZGYwOTAzMDRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.plYHrjhpSGIor5zlSRCMPTOT9SZN3HDQ73zUsoXkhZw"
        },
      );

      if (response.statusCode == 200) {
        // print("Movie Screen Shot Response: ${response.body}");
        return screenshotResponse.fromJson(json.decode(response.body));
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
        throw Exception("Failed to load movie details");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("Failed to fetch movie details: $e");
    }
  }
  }


