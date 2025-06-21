

import '../../Domain/Entity/greenhouse.dart';
import '../../Domain/Repositories/greenhouse_repository.dart';
import '../Models/greenhouse_model.dart';
import '../Sources/Local Sources/greenhouse_local_data_source.dart';
import '../Sources/Remote Sources/greenhouse_remote_data_source.dart';

class GreenhouseRepositoryImpl implements GreenhouseRepository {
  final GreenhouseLocalDataSource localDataSource;
  final GreenhouseRemoteDataSource remoteDataSource;

  GreenhouseRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<void> addGreenhouse(Greenhouse greenhouse) async {
    final model = GreenhouseModel.fromEntity(greenhouse);
    await localDataSource.addGreenhouse(model);
    await remoteDataSource.addGreenhouse(model);
  }

  @override
  Future<void> editGreenhouse(Greenhouse greenhouse) async {
    final model = GreenhouseModel.fromEntity(greenhouse);
    await localDataSource.updateGreenhouse(model);
    await remoteDataSource.updateGreenhouse(model);
  }

  @override
  Future<void> deleteGreenhouse(String id) async {
    await localDataSource.deleteGreenhouse(id);
    await remoteDataSource.deleteGreenhouse(id);
  }

  @override
  Future<List<Greenhouse>> getGreenhouses(String? userId) async {
    final models = await localDataSource.getGreenhouses(userId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> syncGreenhouseData(String greenhouseId) async {
    final oneYearAgo = DateTime.now().subtract(Duration(days: 365)).millisecondsSinceEpoch;
    final localData = await localDataSource.getGreenhouseData(greenhouseId, oneYearAgo);
    final remoteData = await remoteDataSource.getGreenhouseData(greenhouseId, oneYearAgo);
    await localDataSource.syncGreenhouseData(remoteData);
  }

  @override
  Future<void> deleteOldData() async {
    await localDataSource.deleteOldData();
  }
}