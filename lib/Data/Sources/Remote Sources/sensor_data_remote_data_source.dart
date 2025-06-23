import 'package:greenhouse_automation/Common/Constants/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Models/sensor_data_model.dart';

class SensorDataRemoteDataSource {
  final String _baseUrl = AppURLs.baseUrl;

  Future<List<SensorDataModel>> getSensorData(String greenhouseId, int startTime) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/greenhouses/$greenhouseId/sensor_data?start=$startTime'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => SensorDataModel.fromJson(json)).toList();
    }
    throw Exception('Failed to fetch sensor data: ${response.statusCode}');
  }
}