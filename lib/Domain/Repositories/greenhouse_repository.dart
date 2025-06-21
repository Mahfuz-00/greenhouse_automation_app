import '../Entity/greenhouse.dart';

abstract class GreenhouseRepository {
  Future<void> addGreenhouse(Greenhouse greenhouse);
  Future<void> editGreenhouse(Greenhouse greenhouse);
  Future<void> deleteGreenhouse(String id);
  Future<List<Greenhouse>> getGreenhouses(String? userId);
  Future<void> syncGreenhouseData(String greenhouseId);
  Future<void> deleteOldData();
}