import 'package:greenhouse_automation/Common/Constants/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Models/control_item_model.dart';

class ControlItemRemoteDataSource {
  final String _baseUrl = AppURLs.baseUrl;

  Future<List<ControlItemModel>> getControlItems(String greenhouseId) async {
    final response = await http.get(Uri.parse('$_baseUrl/greenhouses/$greenhouseId/control_items'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => ControlItemModel.fromJson(json)).toList();
    }
    throw Exception('Failed to fetch control items: ${response.statusCode}');
  }

  Future<void> updateControlItem(ControlItemModel controlItem) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/greenhouses/${controlItem.greenhouseId}/control_items/${controlItem.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(controlItem.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update control item: ${response.statusCode}');
    }
  }
}