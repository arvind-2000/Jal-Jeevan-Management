import '../entities/waterlevelentity.dart';

abstract class WaterLevelRepositories{

  Future<Map<List<WaterLevel>,int>> getWaterLevel({ required String url});
  Future<Map<List<WaterLevel>,int>> getWaterLevelLatest({ required String url});
  Future<Map<bool,int>> getStatus({ required String url});
  
  Future<int> getAutoPumpStatus({ required String url});
  

}