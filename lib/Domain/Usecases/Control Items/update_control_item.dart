import '../../Entity/control_item.dart';
import '../../Repositories/control_item_repository.dart';

class UpdateControlItem {
  final ControlItemRepository repository;

  UpdateControlItem(this.repository);

  Future<void> call(ControlItem controlItem) async {
    await repository.updateControlItem(controlItem);
  }
}