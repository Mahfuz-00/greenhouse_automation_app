import '../../Repositories/greenhouse_repository.dart';

class DeleteGreenhouse {
  final GreenhouseRepository repository;

  DeleteGreenhouse(this.repository);

  Future<void> call(String id) async {
    await repository.deleteGreenhouse(id);
  }
}