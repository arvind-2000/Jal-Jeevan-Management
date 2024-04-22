import '../entities/waterlevelentity.dart';

abstract class WaterLevelRepositories{

  Future<List<WaterLevel>> getWaterLevel({ required String url});
  Future<List<WaterLevel>> getWaterLevelLatest({ required String url});
  
  Future<bool> pump();

}