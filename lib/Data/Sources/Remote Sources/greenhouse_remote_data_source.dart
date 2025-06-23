import 'package:greenhouse_automation/Common/Constants/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Models/greenhouse_model.dart';


class GreenhouseRemoteDataSource {
  final String _baseUrl = AppURLs.baseUrl;

  Future<void> addGreenhouse(GreenhouseModel greenhouse) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/greenhouses'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(greenhouse.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add greenhouse: ${response.statusCode}');
    }
  }

  Future<void> updateGreenhouse(GreenhouseModel greenhouse) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/greenhouses/${greenhouse.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(greenhouse.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update greenhouse: ${response.statusCode}');
    }
  }

  Future<void> deleteGreenhouse(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/greenhouses/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete greenhouse: ${response.statusCode}');
    }
  }

  Future<List<GreenhouseModel>> getGreenhouseData(String greenhouseId, int startTime) async {
    final response = await http.get(Uri.parse('$_baseUrl/greenhouses/$greenhouseId?start=$startTime'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => GreenhouseModel.fromJson(json)).toList();
    }
    throw Exception('Failed to fetch greenhouse data: ${response.statusCode}');
  }
}