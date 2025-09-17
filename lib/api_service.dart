import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class ApiService {

  final String baseUrl = "http://10.0.2.2:5000/api";    /// for android emulator
  // final String baseUrl = "http://localhost:5000/api";    /// for iOS simulator
  // final String baseUrl = "http://10.54.64.146:5000/api";    /// for real device

  final storage = FlutterSecureStorage();

  Future<String?> register (String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"content/type" : "application/json"},
      body: jsonEncode({"username" : username, "password" : password})
    );

    if (response.statusCode == 200) {
      log("Register response body ${response.body}");
      return "Register Successful!!";
    }
    return "error ${response.body}";
  }

  Future<String?> login (String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"content/type" : "application/json"},
      body: jsonEncode({"username" : username, "password" : password})
    );

    if (response.statusCode == 200) {
      log("Login response body ${response.body}");
      return "Login Successful!!";
    }
    return "error ${response.body}";
  }

  Future<List<dynamic>> getTodos () async {
    final token = await storage.read(key: "token");
    final response = await http.get(
      Uri.parse("$baseUrl/todos"),
      headers: {"Authorization" : "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load todos");
    }
  }

  Future<void> addTodo (String text) async {
    final token = await storage.read(key: "token");
    await http.post(
      Uri.parse("$baseUrl/todos"),
      headers: {
        "Authorization" : "Bearer $token",
        "content/type" : "application.json",
      },
      body: jsonEncode({"text" : text})
    );
  }

}