import '../../Repositories/greenhouse_repository.dart';

class DeleteOldData {
  final GreenhouseRepository repository;

  DeleteOldData(this.repository);

  Future<void> call() async {
    await repository.deleteOldData();
  }
}