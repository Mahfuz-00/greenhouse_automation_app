import '../../Entity/greenhouse.dart';
import '../../Repositories/greenhouse_repository.dart';

class GetGreenhouses {
  final GreenhouseRepository repository;

  GetGreenhouses(this.repository);

  Future<List<Greenhouse>> call(String? userId) async {
    return await repository.getGreenhouses(userId);
  }
}