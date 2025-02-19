import 'package:movies/Model/profile_response.dart';
import 'package:movies/Model/watchlist_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class profileManager {
  static Future<profileResponse?> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    Uri url = Uri.parse("https://route-movie-apis.vercel.app/profile");
    if (token == null) {
      throw Exception('Token not found!');
    }
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print("Profile Data: $data");
        return profileResponse.fromJson(data);
      }
      if (response.statusCode == 404) {
        print("User not found. Logging out...");
        await prefs.remove('auth_token');
      }

      if (response.statusCode == 401) {
        print("Token expired. Logging out...");
        await prefs.remove('auth_token');
      } else {
        throw Exception("Failed to fetch profile: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching profile: $e");
    }
    return null;
  }

  static Future<void> updateProfile(
      String? name, String? phone, int? avatarId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    Uri url = Uri.parse("https://route-movie-apis.vercel.app/profile");
    if (token == null) {
      throw Exception('Token not found!');
    }
    try {
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "phone": phone?.replaceAll(RegExp(r'\s+'), ''),
          "avaterId": avatarId,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Profile Updated Successfuly: $data");
      } else {
        throw Exception("Failed to Update profile: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error Updating profile: $e");
    }
  }

  static Future<void> deleteProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    Uri url = Uri.parse("https://route-movie-apis.vercel.app/profile");

    if (token == null) {
      print("No token found. Redirecting to login.");
      return;
    }

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("Profile deleted successfully");
        await prefs.remove('auth_token');
        print("Token deleted successfully");
      } else {
        throw Exception("Failed to delete profile: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error deleting profile: $e");
    }
  }

  static Future<void> addToWatchList({
    required int movieId,
    required String name,
    required double rating,
    required String posterPath,
    required String year,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token not found!');
    }

    Uri url = Uri.parse("https://route-movie-apis.vercel.app/favorites/add");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "movieId": movieId.toString(),
          "name": name,
          "rating": rating,
          "imageURL": posterPath,
          "year": year,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey("success") && data["success"] == true) {
          print("Movie added successfully: $data");
        } else {
          print("Unexpected API response: $data");
          throw Exception("Failed to add movie. Unexpected response format.");
        }
      } else {
        print(
            "Failed to add movie. Status Code: ${response.statusCode}, Response: ${response.body}");
        throw Exception("Failed to add movie: ${response.body}");
      }
    } catch (e) {
      print("Error adding movie: $e");
      throw Exception("Error adding movie: $e");
    }
  }

  static Future<watchListResponse> getWatchList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      print("No token found!");
      return watchListResponse(data: []);
    }

    Uri url = Uri.parse("https://route-movie-apis.vercel.app/favorites/all");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        // print("Watch List Movies: ${response.body}");

        return watchListResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to load watchlist: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception('Error fetching watchlist data: $e');
    }
  }

  static Future<bool> isMovieBookmarked(int movieId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      print("No token found. User is not logged in.");
      return false;
    }

    Uri url = Uri.parse(
        "https://route-movie-apis.vercel.app/favorites/is-favorite/$movieId");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('data')) {
          return data['data'] as bool;
        } else {
          print("Unexpected API response: ${response.body}");
          return false;
        }
      } else {
        print(
            "Failed to load bookmark status. Status Code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error checking bookmark status: $e");
      return false;
    }
  }

  static Future<void> deleteWatchListMovie(int movieId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    Uri url = Uri.parse(
        "https://route-movie-apis.vercel.app/favorites/remove/$movieId");

    if (token == null) {
      print("No token found. Redirecting to login.");
      return;
    }

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("Movie deleted successfully");
      } else {
        throw Exception("Failed to delete the movie: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error deleting the movie: $e");
    }
  }
}
