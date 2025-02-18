import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterApi {
  final String baseUrl = "https://route-movie-apis.vercel.app";

  Future<Map<String, dynamic>> registerUser(String name, String email, String password, String confirmPassword, String phone, int avaterId) async {
    final Uri url = Uri.parse("$baseUrl/auth/register");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "phone": phone,
          "avaterId": avaterId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "message": "Registration successful!",
          "data": jsonDecode(response.body),
        };
      } else {
        return {
          "success": false,
          "message":
              jsonDecode(response.body)["error"] ?? "Registration failed",
        };
      }
    } catch (error) {
      return {
        "success": false,
        "message": "An error occurred: $error",
      };
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final Uri url = Uri.parse("$baseUrl/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData["data"]; // Token is stored in the "data" field

        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('auth_token');
          await prefs.setString('auth_token', token);

          print("✅ Login successful. New token saved.");
        } else {
          print("⚠️ Warning: No token received from API.");
        }

        return {
          "success": true,
          "message": responseData["message"],
          "data": token,
        };
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)["error"] ?? "Login failed",
        };
      }
    } catch (error) {
      return {
        "success": false,
        "message": "An error occurred: $error",
      };
    }
  }




}
