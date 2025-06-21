import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Models/sensor_data_model.dart';

class SensorDataRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<SensorDataModel>> getSensorData(String greenhouseId, int startTime) async {
    final sevenDaysAgo = DateTime.now().subtract(Duration(days: 7)).millisecondsSinceEpoch;
    // Firebase for last 7 days
    final firebaseData = await _firestore
        .collection('greenhouses')
        .doc(greenhouseId)
        .collection('sensor_data')
        .where('timestamp', isGreaterThanOrEqualTo: sevenDaysAgo)
        .get();
    final firebaseModels = firebaseData.docs.map((doc) => SensorDataModel.fromJson(doc.data())).toList();

    // Local device API for older data
    final response = await http.get(Uri.parse('https://local-device-api/greenhouses/$greenhouseId/sensor_data?start=$startTime'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final deviceModels = jsonData.map((json) => SensorDataModel.fromJson(json)).toList();
      return [...firebaseModels, ...deviceModels];
    }
    return firebaseModels;
  }
}