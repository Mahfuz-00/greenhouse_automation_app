import '../../Entity/greenhouse.dart';
import '../../Repositories/greenhouse_repository.dart';

class AddGreenhouse {
  final GreenhouseRepository repository;

  AddGreenhouse(this.repository);

  Future<void> call(Greenhouse greenhouse) async {
    await repository.addGreenhouse(greenhouse);
  }
}