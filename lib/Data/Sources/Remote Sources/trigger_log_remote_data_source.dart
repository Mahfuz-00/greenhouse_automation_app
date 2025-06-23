import 'package:greenhouse_automation/Common/Constants/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Models/trigger_log_model.dart';

class TriggerLogRemoteDataSource {
  final String _baseUrl = AppURLs.baseUrl;

  Future<List<TriggerLogModel>> getTriggerLogs(String greenhouseId, int startTime) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/greenhouses/$greenhouseId/trigger_logs?start=$startTime'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => TriggerLogModel.fromJson(json)).toList();
    }
    throw Exception('Failed to fetch trigger logs: ${response.statusCode}');
  }
}