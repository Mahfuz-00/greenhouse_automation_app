import 'package:greenhouse_automation/Common/Constants/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Models/user_model.dart';


class UserRemoteDataSource {
  final String _baseUrl = AppURLs.baseUrl;

  Future<void> addUser(UserModel user) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add user: ${response.statusCode}');
    }
  }

  Future<void> updateUser(UserModel user) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/users/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/users/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user: ${response.statusCode}');
    }
  }

  Future<UserModel?> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UserModel.fromJson(jsonData['user']);
    }
    return null;
  }

  Future<void> signupUser(UserModel user, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        ...user.toJson(),
        'password': password,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to sign up user: ${response.statusCode}');
    }
  }
}