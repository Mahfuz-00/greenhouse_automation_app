import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/greenhouse_model.dart';

class GreenhouseRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addGreenhouse(GreenhouseModel greenhouse) async {
    await _firestore.collection('greenhouses').doc(greenhouse.id).set(greenhouse.toJson());
  }

  Future<void> updateGreenhouse(GreenhouseModel greenhouse) async {
    await _firestore.collection('greenhouses').doc(greenhouse.id).update(greenhouse.toJson());
  }

  Future<void> deleteGreenhouse(String id) async {
    await _firestore.collection('greenhouses').doc(id).delete();
  }

  Future<List<GreenhouseModel>> getGreenhouseData(String greenhouseId, int startTime) async {
    final snapshot = await _firestore
        .collection('greenhouses')
        .where('id', isEqualTo: greenhouseId)
        .where('last_updated', isGreaterThanOrEqualTo: startTime)
        .get();
    return snapshot.docs.map((doc) => GreenhouseModel.fromJson(doc.data())).toList();
  }
}