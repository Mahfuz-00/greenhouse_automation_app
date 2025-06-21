import '../Entity/control_item.dart';

abstract class ControlItemRepository {
  Future<List<ControlItem>> getControlItems(String greenhouseId);
  Future<void> updateControlItem(ControlItem controlItem);
}