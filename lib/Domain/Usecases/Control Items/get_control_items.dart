import '../../Entity/control_item.dart';
import '../../Repositories/control_item_repository.dart';

class GetControlItems {
  final ControlItemRepository repository;

  GetControlItems(this.repository);

  Future<List<ControlItem>> call(String greenhouseId) async {
    return await repository.getControlItems(greenhouseId);
  }
}