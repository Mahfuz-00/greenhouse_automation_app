import '../../Repositories/greenhouse_repository.dart';

class SyncGreenhouseData {
  final GreenhouseRepository repository;

  SyncGreenhouseData(this.repository);

  Future<void> call(String greenhouseId) async {
    await repository.syncGreenhouseData(greenhouseId);
  }
}