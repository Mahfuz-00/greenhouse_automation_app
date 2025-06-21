

import '../../Domain/Entity/control_item.dart';
import '../../Domain/Repositories/control_item_repository.dart';
import '../Models/control_item_model.dart';
import '../Sources/Local Sources/control_item_local_data_source.dart';
import '../Sources/Remote Sources/control_item_remote_data_source.dart';

class ControlItemRepositoryImpl implements ControlItemRepository {
  final ControlItemLocalDataSource localDataSource;
  final ControlItemRemoteDataSource remoteDataSource;

  ControlItemRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<List<ControlItem>> getControlItems(String greenhouseId) async {
    final models = await localDataSource.getControlItems(greenhouseId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateControlItem(ControlItem controlItem) async {
    final model = ControlItemModel.fromEntity(controlItem);
    await localDataSource.updateControlItem(model);
    await remoteDataSource.updateControlItem(model);
  }
}