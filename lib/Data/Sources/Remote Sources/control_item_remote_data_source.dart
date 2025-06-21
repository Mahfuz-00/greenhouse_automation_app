import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Models/control_item_model.dart';

class ControlItemRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ControlItemModel>> getControlItems(String greenhouseId) async {
    // Initially from local device API
    final response = await http.get(Uri.parse('https://local-device-api/greenhouses/$greenhouseId/control_items'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => ControlItemModel.fromJson(json)).toList();
    }
    // Fallback to Firebase
    final snapshot = await _firestore.collection('greenhouses').doc(greenhouseId).collection('control_items').get();
    return snapshot.docs.map((doc) => ControlItemModel.fromJson(doc.data())).toList();
  }

  Future<void> updateControlItem(ControlItemModel controlItem) async {
    await _firestore
        .collection('greenhouses')
        .doc(controlItem.greenhouseId)
        .collection('control_items')
        .doc(controlItem.id)
        .set(controlItem.toJson());
  }
}