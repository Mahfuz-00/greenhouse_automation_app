import '../../Entity/greenhouse.dart';
import '../../Repositories/greenhouse_repository.dart';

class EditGreenhouse {
  final GreenhouseRepository repository;

  EditGreenhouse(this.repository);

  Future<void> call(Greenhouse greenhouse) async {
    await repository.editGreenhouse(greenhouse);
  }
}